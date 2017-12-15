# frozen_string_literal: true

require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Search
  # Config for the app.
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    #
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    config.time_zone = 'Australia/Melbourne'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path +=
    #   Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.path_to_broadcast_file = "#{ENV['HOME']}/.nsl/broadcast.txt"
    config.active_record.schema_format = :sql
    config.cache_store = :memory_store, { size: 64.megabytes }
  end
end

Rails.configuration.name_label = ''
Rails.configuration.taxonomy_label = ''
Rails.configuration.rank_options = []
