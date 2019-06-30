Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: ENV.fetch('REDIS_URL') }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = { url: ENV.fetch('REDIS_URL') }
  end
end
