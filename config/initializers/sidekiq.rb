require 'sidekiq'
require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

# Password protection for Sidekiq Web UI
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # These defaults to easily catch if you forget to set them
  username == ENV.fetch("SIDEKIQ_USERNAME", "admin") &&
  password == ENV.fetch("SIDEKIQ_PASSWORD", "password")
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end