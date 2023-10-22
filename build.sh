#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Build and push both dev and production
./bld_development.sh
./bld_production.sh
