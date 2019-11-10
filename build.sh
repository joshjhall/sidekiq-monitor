#!/bin/bash

# Pull pre-requesite container
docker pull ruby:2.6-alpine

# Build the container
docker build -t joshjhall/sidekiq-monitor .

# Push the container update
docker push joshjhall/sidekiq-monitor

# Delete local images to clean things up
docker rmi ruby:2.6-alpine
docker rmi joshjhall/sid ekiq-monitor
