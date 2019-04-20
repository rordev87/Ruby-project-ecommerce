require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module A
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
	Bundler.require(*Rails.groups)
    Config::Integrations::Rails::Railtie.preload

    # ...

    config.time_zone = Settings.time_zone
	config.i18n.default_locale = :vi
    config.eager_load_paths << Rails.root.join("lib/cookie_products")
    config.eager_load_paths << Rails.root.join("lib/session_carts")
	
  end
end

