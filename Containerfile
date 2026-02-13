FROM quay.io/fedora/fedora-bootc:43

COPY scripts/load_embedded_images.sh /usr/bin/
RUN chmod +x /usr/bin/load_embedded_images.sh

# Quadlet directory
RUN mkdir -p /etc/containers/systemd \
    /var/lib/dev-platform/gitea

# Copy quadlet units
COPY quadlet/*.container /etc/containers/systemd/

# Create cache directory and embed the images
RUN mkdir -p /usr/lib/containers-image-cache/gitea && \
    \
    # Physically embed selected images using skopeo
    skopeo copy --preserve-digests docker://docker.io/gitea/gitea:1.25 \
      dir:/usr/lib/containers-image-cache/gitea

# Copy load embed unit file
COPY systemd/*.service /etc/systemd/system/

# Enable podman + quadlet
RUN systemctl enable podman.service && \
    systemctl enable load-embedded-images.service

LABEL org.opencontainers.image.title="bootc Dev Platform Appliance"
LABEL org.opencontainers.image.version="1.0.0"
