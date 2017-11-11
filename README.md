# Introduction
This is a simple docker container to monitor sidekiq queues.

# Environment variables
`REDIS_URL` = Redis URL (e.g., `redis://someserver.com:6379`)

`SIDEKIQ_NAMESPACE` = Redis namespace to monitor (currently falls back to "default" if not set)

`REDIS_SENTINEL_SERVICE` = Optionally use the sentinal service

# Port
Uses the default sidekiq monitor port `9292` internally

# Revision history
2017-07-23: Initial commit
2017-11-11: Update version of Sidekiq