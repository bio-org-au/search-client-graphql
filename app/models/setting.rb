# frozen_string_literal: true

# Quacks like a rails model
class Setting
  DATA_SERVER = Rails.configuration.data_server

  def name_label
    @name_label ||= ask_for_setting('name label')
  end

  def tree_label
    taxonomy_label
  end

  def taxonomy_label
    @taxonomy_label ||= ask_for_setting('tree label')
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
