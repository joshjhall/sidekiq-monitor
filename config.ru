#!usr/bin/ruby

# Sidekiq monitor
# Required packages
require 'sidekiq'
require 'sidekiq-status'

# Set external encoding to avoid invalid byte sequence when displaying unicode
Encoding.default_external = Encoding::UTF_8

# Configure client
Sidekiq.configure_client do |config|
  config.redis =
    if ENV['REDIS_SENTINEL_SERVICE'].nil?
      if ENV['SIDEKIQ_NAMESPACE'].nil?
        { url: (ENV['REDIS_URL'] || 'redis://redis') }
      else
        {
          url: (ENV['REDIS_URL'] || 'redis://redis'),
          namespace: (ENV['SIDEKIQ_NAMESPACE'] || 'default')
        }
      end
    else
      if ENV['SIDEKIQ_NAMESPACE'].nil?
        {
          url: (ENV['REDIS_URL'] || 'redis://redis'),
          sentinels: [{ host: ENV['REDIS_SENTINEL_SERVICE'], port: '26379' }]
        }
      else
        {
          url: (ENV['REDIS_URL'] || 'redis://mymaster'),
          namespace: (ENV['SIDEKIQ_NAMESPACE'] || 'default'),
          sentinels: [{ host: ENV['REDIS_SENTINEL_SERVICE'], port: '26379' }]
        }
      end
    end
end

require 'set'
require 'sidekiq/web'
require 'sidekiq-status/web'
run Sidekiq::Web
