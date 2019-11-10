# frozen_string_literal: true

require "sidekiq"
require "set"
require "sidekiq/web"

# Set external encoding to avoid invalid byte sequence when displaying unicode
Encoding.default_external = Encoding::UTF_8

settings = { url: (ENV["REDIS_URL"] || "redis://redis:6379") }

# Add namespace if configured
if !ENV["SIDEKIQ_NAMESPACE"].nil?
  settings[:namespace] = (ENV["SIDEKIQ_NAMESPACE"] || "default")
end

# Add sentinal service if configured
if !ENV["REDIS_SENTINEL_SERVICE_URL"].nil?
  settings[:sentinels] = [{ host: ENV["REDIS_SENTINEL_SERVICE_URL"], port: (ENV["REDIS_SENTINEL_SERVICE_PORT"] || "26379") }]
end

# Configure client
Sidekiq.configure_client do |config|
  config.redis = settings
end

# Optionally include sidekiq status plugin
if !ENV["SIDEKIQ_STATUS"].nil?
  require "sidekiq-status"
  require "sidekiq-status/web"
end

# Optionally use basic auth to sign into sidekiq
if !ENV["SIDEKIQ_USERNAME"].nil? && !ENV["SIDEKIQ_PASSWORD"].nil?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
end

# Optionally include sidekiq unique jobs plugin
if !ENV["SIDEKIQ_UNIQUE_JOBS"].nil?
  require "sidekiq-unique-jobs"
  require "sidekiq_unique_jobs/web"
end

# Optionally include sidekiq failures plugin
if !ENV["SIDEKIQ_FAILURES"].nil?
  require "sidekiq-failures"
end

run Sidekiq::Web
