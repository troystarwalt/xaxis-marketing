# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InternalSite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.exceptions_app = self.routes
    config.middleware.use Rack::Deflater
    # config.middleware.swap(Rack::MiniProfiler, nil)
    # config.middleware.delete(nil)
    # config.middleware.insert_after(Rack::Deflater, Rack::MiniProfiler)
    config.font_assets.origin = "*"
  end
end
