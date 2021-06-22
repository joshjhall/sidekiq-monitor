# Version v1.3

FROM ruby:2.6-alpine

LABEL repository="joshjhall/sidekiq-monitor"
LABEL maintainer="josh@yaplabs.com"

# Install dependencies
RUN gem install \
    rack \
    sidekiq \
    redis-namespace \
    sidekiq-status \
    sidekiq-failures \
    sidekiq-unique-jobs

# Copy config.ru
COPY config.ru config.ru

# Configure environment variables
ENV RAILS_ENV="development"
ENV REDIS_PORT="6379"

# Optional envrionment variables used, but not set during build
# ENV REDIS_SENTINEL_SERVICE_URL
# ENV REDIS_SENTINEL_SERVICE_PORT
# ENV SIDEKIQ_NAMESPACE
# ENV SIDEKIQ_STATUS
# ENV SIDEKIQ_USERNAME
# ENV SIDEKIQ_PASSWORD
# ENV REDIS_URL
# ENV REDIS_HOST

# Expose port
EXPOSE 9292

# Set initial command
CMD rackup config.ru --host 0.0.0.0
