# frozen_string_literal: true

require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SearchClient
  class Application < Rails::Application
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Australia/Melbourne'
    config.cache_store = :memory_store, { size: 64.megabytes }
    config.action_controller.include_all_helpers = false
  end
end

Rails.configuration.name_label = ''
Rails.configuration.taxonomy_label = ''
Rails.configuration.rank_options = []
Rails.configuration.default_list_size_limit = 1000
Rails.configuration.default_details_size_limit = 100
Rails.configuration.default_list_size = 100
Rails.configuration.default_details_size = 10

