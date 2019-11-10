# Version v1.2

FROM ruby:2.6-alpine

LABEL repository="joshjhall/sidekiq-monitor"
LABEL maintainer="josh@yaplabs.com"

RUN gem install \
    rack \
    sidekiq \
    redis-namespace \
    sidekiq-status \
    sidekiq-failures \
    sidekiq-unique-jobs

COPY config.ru config.ru

ENV REDIS_URL="redis://redis:6379"
ENV RAILS_ENV="development"
ENV REDIS_SENTINEL_SERVICE_URL, \
    REDIS_SENTINEL_SERVICE_PORT, \
    SIDEKIQ_NAMESPACE, \
    SIDEKIQ_STATUS, \
    SIDEKIQ_USERNAME, \
    SIDEKIQ_PASSWORD

EXPOSE 9292

CMD rackup config.ru --host 0.0.0.0
