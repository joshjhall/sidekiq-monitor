#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Build the images for various platforms
docker buildx build \
  --platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/s390x,linux/ppc64le \
  --file development.Dockerfile \
  -t joshjhall/sidekiq-monitor:development \
  --push .
