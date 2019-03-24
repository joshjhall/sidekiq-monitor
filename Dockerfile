# Version v1.1

FROM ruby:2.6-alpine

RUN gem install rack sidekiq redis-namespace sidekiq-status
COPY config.ru config.ru

EXPOSE 9292

CMD rackup config.ru --host 0.0.0.0
