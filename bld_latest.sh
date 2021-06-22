#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Get latest source image
docker pull ruby:3.0-alpine

# Build the images
docker build --file latest.Dockerfile -t joshjhall/sidekiq-monitor:latest .

# Push images
docker push joshjhall/sidekiq-monitor:latest
