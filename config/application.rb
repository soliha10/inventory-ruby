require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module RubyCoursework
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.i18n.available_locales = %i[en uz]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = [:en]
    config.active_storage.touch_attachment_records = false
    config.generators.system_tests = nil
  end
end
