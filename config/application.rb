require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module HeisenBugDev

  def set_db_connection_pool_size!(size=35)
    # bump the AR connection pool
    if ENV['DATABASE_URL'] !~ /pool/
      pool_size = ENV.fetch('DATABASE_POOL_SIZE', size)
      db = URI.parse ENV['DATABASE_URL']
      if db.query
       db.query += "&pool=#{pool_size}"
      else
       db.query = "pool=#{pool_size}"
      end
      ENV['DATABASE_URL'] = db.to_s
      ActiveRecord::Base.establish_connection
    end
  end

  module_function :set_db_connection_pool_size!

  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.template_engine nil
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false
    end

    if Puma.respond_to?(:cli_config)
      ::HeisenBugDev.set_db_connection_pool_size! Puma.cli_config.options.fetch(:max_threads)
    end

    config.to_prepare do
      Devise::SessionsController.skip_before_filter :beta_logged_in
    end

    config.i18n.enforce_available_locales = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
