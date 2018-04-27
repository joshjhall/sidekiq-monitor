FROM ruby:2.4-alpine

# Version 2018-04-27

RUN gem install rack sidekiq redis-namespace
COPY config.ru config.ru

EXPOSE 9292

CMD rackup config.ru --host 0.0.0.0
