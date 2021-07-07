#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Build the images
docker build --file production.Dockerfile -t joshjhall/sidekiq-monitor:production .
docker tag joshjhall/sidekiq-monitor:production joshjhall/sidekiq-monitor:latest

# Push images
docker push joshjhall/sidekiq-monitor:production
docker push joshjhall/sidekiq-monitor:latest
