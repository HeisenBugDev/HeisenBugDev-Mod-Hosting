Sidekiq.configure_server do |config|
  Platform.set_db_connection_pool_size!(Sidekiq.options[:concurrency])
end