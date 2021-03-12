#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Get latest source image
docker pull ruby:2.6-alpine

# Build the images
docker build --file stable.Dockerfile -t joshjhall/sidekiq-monitor:stable .

# Push images
docker push joshjhall/sidekiq-monitor:stable
