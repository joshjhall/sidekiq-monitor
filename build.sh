#!/bin/bash

# Pull pre-requesite container
docker pull ruby:2.6-alpine

# Build the container
docker build -t registry.stoic.studio/sidekiq-monitor .

# Push container
docker push registry.stoic.studio/sidekiq-monitor
