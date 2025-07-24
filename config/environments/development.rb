Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  
  # In development, code is reloaded on every request
  config.cache_classes = false
  config.eager_load = false
  
  # Show full error reports
  config.consider_all_requests_local = true
  
  # Enable/disable caching
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :redis_cache_store, {
      pool: $redis,
      expires_in: 1.hour,
      namespace: 'cache:development'
    }
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs
  config.active_record.verbose_query_logs = true

  # Asset pipeline configuration
  config.assets.debug = true
  config.assets.quiet = true
  config.assets.compile = true
  config.assets.digest = true
  
  # Use Rails logger
  config.logger = Logger.new(STDOUT) if ENV['RAILS_LOG_TO_STDOUT'].present?
end
