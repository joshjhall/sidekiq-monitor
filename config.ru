#!usr/bin/ruby

# Sidekiq monitor
# v1.0.2

# Required packages
require 'sidekiq'

# Set external encoding to avoid invalid byte sequence when displaying unicode
Encoding.default_external = Encoding::UTF_8

# Configure client
Sidekiq.configure_client do |config|
  config.redis =
    if ENV['REDIS_SENTINEL_SERVICE'].nil?
      {
      	url: (ENV['REDIS_URL'] || 'redis://redis'),
      	namespace: (ENV['SIDEKIQ_NAMESPACE'] || 'default')
      }
    else
      {
        url: (ENV['REDIS_URL'] || 'redis://mymaster'),
        namespace: (ENV['SIDEKIQ_NAMESPACE'] || 'default'),
        sentinels: [{ host: ENV['REDIS_SENTINEL_SERVICE'], port: '26379' }]
      }
    end
end

require 'set'
require 'sidekiq/web'
run Sidekiq::Web
