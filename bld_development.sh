#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Build the images
docker build --file development.Dockerfile -t joshjhall/sidekiq-monitor:development .

# Push images
docker push joshjhall/sidekiq-monitor:development
