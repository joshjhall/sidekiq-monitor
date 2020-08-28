# Introduction
This is a simple docker container to monitor sidekiq queues.

## Environment variables

### Redis

`REDIS_URL` = Redis URL (e.g., `redis://redis_local:6379`).  This will override `REDIS_HOST` and `REDIS_PORT`, because the host and port are part of the URL.  So, do not set this envrionment variable if you want to use the host/port instead.

`REDIS_HOST` = Redis hostname only (e.g., `redis_local`).  This can be used in conjunction with `REDIS_PORT`.  When using docker-compose or a stack, this is usually all you'll need to set for the Redis connection (see `docker-compose.yml` example)

`REDIS_PORT` = Redis port used with the hostname.  This defaults to `6379`.

If neither `REDIS_URL` nor `REDIS_HOST` are set, it defaults to `redis://redis:6379` for common stack/service arrangments.

### Redis Sentinel

`REDIS_SENTINEL_SERVICE_URL` = Optionally use the sentinel service (e.g., `redis://sentinel.local`).

`REDIS_SENTINEL_SERVICE_PORT` = Specify the sentinel service port to be used (e.g., `26379`).  Defaults to `26379` as the standard port.

### Sidekiq plugins

`SIDEKIQ_NAMESPACE` = Optionally set a Redis namespace to monitor (e.g., `my_namespace`)

`SIDEKIQ_STATUS` = Optionally use the Sidekiq Status plugin.  To enable, just set this env variable to `enable`.

`SIDEKIQ_UNIQUE_JOBS` = Optionally use the Sidekiq Unique Jobs plugin.  To enable, just set this env variable to `enable`.  This idea was borrowed/stolen from @onigra.

`SIDEKIQ_FAILURES` = Optionally use the Sidekiq Failures plugin.  To enable, just set this env variable to `enable`.  This idea was borrowed/stolen from @onigra.

### General environment variables

`RAILS_ENV` = production, development, etc.  I believe this just changes the title of the page, so you can differentiate between environments.

### Add basic auth to the sidekiq monitor

This idea was borrowed/stolen from @Hunk13.  Optionally add basic auth to the sidekiq monitor.  This will only be enabled if both a username and password are set.

`SIDEKIQ_USERNAME` = Username (e.g., `deckard`)

`SIDEKIQ_PASSWORD` = Password (e.g., `replicant?TRUE`)


## Exposed web server

Uses the default sidekiq web port `9292` internally

`SIDEKIQ_URL` = the url to mount the web UI on (default: '/')


## Example
```
docker run -d \
  --name sidekiq \
  -p 9292:9292 \
  -e "REDIS_URL=redis://redis.local" \
  -e "SIDEKIQ_NAMESPACE=myapp" \
  -e "SIDEKIQ_STATUS=enable" \
  -e "REDIS_SENTINEL_SERVICE_URL=redis://sentinel" \
  -e "REDIS_SENTINEL_SERVICE_PORT=22666" \
  -e "RAILS_ENV=production" \
  -e "SIDEKIQ_URL=/admin/queue \
  joshjhall/sidekiq-monitor
```


# Revision history

* 2020-08-28: Added optional parameter SIDEKIQ_URL to mount web UI on a sub path
* 2019-11-20: Added optional use of REDIS_HOST/REDIS_PORT instead of REDIS_URL to simplify initialization in some circumstances
* 2019-11-10: Added optional sidekiq unique jobs and sidekiq failures plugin support
* 2019-11-10: Added optional basic auth
* 2019-11-10: Decompose URL and port environment variables for Redis Sentinel
* 2019-03-02: Add support for sidekiq status, bump version of ruby and gems
* 2018-05-10: Improved readme
* 2018-05-05: Support without namespace
* 2018-04-27: Bump version
* 2017-11-11: Update version of Sidekiq
* 2017-07-23: Initial commit
