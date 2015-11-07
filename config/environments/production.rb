Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = true

  config.assets.js_compressor = :uglifier
  config.assets.compile = false

  config.assets.digest = true

  config.assets.version = '1.0'

  config.log_level = :info

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => ENV['GMAIL_ADDRESS'],
    :password             => ENV['GMAIL_PASSWORD'],
    :authentication       => 'login',
    :enable_starttls_auto => true
  }

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
end
