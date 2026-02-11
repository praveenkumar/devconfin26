#!/usr/bin/env bash

# Put images into Podman container store
# The “dir:” directories were previously embedded at build time

echo "Loading Gitea image into container-storage"
skopeo copy \
  dir:/usr/lib/containers-image-cache/gitea \
  containers-storage:docker.io/gitea/gitea:1.25

echo "Loading Registry image into container-storage"
skopeo copy \
  dir:/usr/lib/containers-image-cache/registry \
  containers-storage:docker.io/registry:3.0
