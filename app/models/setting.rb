# frozen_string_literal: true

# Get settings from the server.
class Setting
  DATA_SERVER = Rails.configuration.data_server

  def name_label
    if Rails.configuration.name_label.blank?
      Rails.configuration.name_label = ask_for_setting('name label')
    else
      Rails.configuration.name_label
    end
  end

  def tree_label
    taxonomy_label
  end

  def taxonomy_label
    if Rails.configuration.taxonomy_label.blank?
      Rails.configuration.taxonomy_label = ask_for_setting('taxonomy label')
    else
      Rails.configuration.taxonomy_label
    end
  end

  private

  def ask_for_setting(setting)
    options = {
      body: {
        query: %({setting(search_term: "#{setting}") })
      }
    }
    Rails.logger.debug(options.inspect)
    json = HTTParty.post("#{DATA_SERVER}/v1", options)
    @search = JSON.parse(json.to_s, object_class: OpenStruct)
    @search.data.setting
  end
end
