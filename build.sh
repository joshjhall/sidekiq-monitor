#!/bin/zsh

# Change working directory to where the script is located
cd "$(dirname "$0")"

# Build all
./bld_development.sh
./bld_production.sh
