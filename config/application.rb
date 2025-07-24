require_relative 'boot'

require "rails"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile
Bundler.require(*Rails.groups)

module RailsStarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version
    config.load_defaults 5.2
    
    # Application configuration
    config.encoding = "utf-8"
    
    # Configure sensitive parameters which will be filtered from the log file
    config.filter_parameters += [:password]
    
    # Enable escaping HTML in JSON
    config.active_support.escape_html_entities_in_json = true
  end
end
