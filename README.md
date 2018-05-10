# Introduction
This is a simple docker container to monitor sidekiq queues.

## Environment variables
`REDIS_URL` = Redis URL (e.g., `redis://someserver.com:6379`)

`SIDEKIQ_NAMESPACE` = Optionally set a Redis namespace to monitor

`REDIS_SENTINEL_SERVICE` = Optionally use the sentinal service

`RAILS_ENV` = production, development, etc.  I believe this just changes the title of the page, so you can differentiate between environments.

## Port
Uses the default sidekiq web port `9292` internally

## Example
```
docker run -d \
  --name sidekiq \
  -p 9292:9292 \
  -e "REDIS_URL=redis://someserver.com:6379" \
  -e "SIDEKIQ_NAMESPACE=myapp" \
  -e "RAILS_ENV=production" \
  joshjhall/sidekiq-monitor
```


# Revision history

* 2017-07-23: Initial commit
* 2017-11-11: Update version of Sidekiq
* 2018-04-27: Bump version
* 2018-05-05: Support without namespace
* 2018-05-10: Improved readme
