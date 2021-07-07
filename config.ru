# frozen_string_literal: true

require "set"
require "sidekiq"
require "sidekiq/web"
require "securerandom"

# Set external encoding to avoid invalid byte sequence when displaying unicode
Encoding.default_external = Encoding::UTF_8

# Check if we should use the REDIS_HOST instead of REDIS_URL variable
if ENV["REDIS_URL"].to_s.strip.empty? && !ENV["REDIS_HOST"].to_s.strip.empty?
  redis_url = "redis://#{ENV["REDIS_HOST"]}:#{ENV["REDIS_PORT"]}"
else
  redis_url = ENV["REDIS_URL"]
end

settings = { url: (redis_url || "redis://redis:6379") }

# Add namespace if configured
unless ENV["SIDEKIQ_NAMESPACE"].nil?
  settings[:namespace] = (ENV["SIDEKIQ_NAMESPACE"] || "default")
end

# Add sentinal service if configured
unless ENV["REDIS_SENTINEL_SERVICE_URL"].nil?
  settings[:sentinels] = [{ host: ENV["REDIS_SENTINEL_SERVICE_URL"], port: (ENV["REDIS_SENTINEL_SERVICE_PORT"] || "26379") }]
end

# Configure client
Sidekiq.configure_client do |config|
  config.redis = settings
end

# Optionally include sidekiq status plugin
if ENV["SIDEKIQ_STATUS"].to_s.downcase == "enable"
  require "sidekiq-status"
  require "sidekiq-status/web"
end

# Optionally use basic auth to sign into sidekiq
unless (ENV["SIDEKIQ_USERNAME"].nil? && ENV["SIDEKIQ_PASSWORD"].nil?)
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
end

# Optionally include sidekiq unique jobs plugin
if ENV["SIDEKIQ_UNIQUE_JOBS"].to_s.downcase == "enable"
  require "sidekiq-unique-jobs"
  require "sidekiq_unique_jobs/web"
end

# Optionally include sidekiq failures plugin
if ENV["SIDEKIQ_FAILURES"].to_s.downcase == "enable"
  require "sidekiq-failures"
end

# Create random session key
File.open(".session.key", "w") do |f|
  f.write(SecureRandom.hex(32))
end

# Add session cookie middleware
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

# Start the web interface
run Sidekiq::Web
