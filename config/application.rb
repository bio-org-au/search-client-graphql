# frozen_string_literal: true
require File.expand_path("../boot", __FILE__)

require "csv"
require "rails/all"

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
    config.time_zone = "Australia/Melbourne"
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

    config.after_initialize do
      puts "Loading shard configuration..."
      config.banner_text = ShardConfig.banner_text
      config.menu_label = ShardConfig.menu_label
      config.name_label = ShardConfig.name_label
      config.classification_tree_key = ShardConfig.classification_tree_key
      config.description_html = ShardConfig.description_html
      config.tree_description_html = ShardConfig.tree_description_html
      config.name_description_html = ShardConfig.name_description_html
      config.tree_banner_text = ShardConfig.tree_banner_text
      config.tree_label_text = ShardConfig.tree_label_text
      config.page_title = ShardConfig.page_title
      config.services_path_name_element = ShardConfig.services_path_name_element
      config.services_path_tree_element = ShardConfig.services_path_tree_element
      config.tree_search_help_text_html = ShardConfig.tree_search_help_text_html
      config.name_search_help_text_html = ShardConfig.name_search_help_text_html
      config.name_link_title = ShardConfig.name_link_title
      config.tree_link_title = ShardConfig.tree_link_title
      config.menu_link_title = ShardConfig.menu_link_title
      config.name_label_text = ShardConfig.name_label_text
      config.name_tree_label = ShardConfig.name_tree_label
      config.name_banner_text = ShardConfig.name_banner_text
      puts "Finished loading shard configuration..."
    end
  end
end
