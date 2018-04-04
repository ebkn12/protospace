require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Protospace
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.helper      false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
