# frozen_string_literal: true

# Get settings from the server.
class Setting
  DATA_SERVER = Rails.configuration.data_server

  def name_label
    if Rails.configuration.name_label.blank?
      Rails.configuration.name_label = setting_for('name label')
    else
      Rails.configuration.name_label
    end
  end

  def tree_label
    if Rails.configuration.try(:tree_label).blank?
      Rails.configuration.tree_label = setting_for('tree label')
    else
      Rails.configuration.try(:tree_label)
    end
  end

  def taxonomy_label
    if Rails.configuration.try(:taxonomy_label).blank?
      Rails.configuration.taxonomy_label = setting_for('tree label')
    else
      Rails.configuration.try(:taxonomy_label)
    end
  end

  private

  def setting_for(setting)
    options = {
      body: {
        query: %({setting(search_term: "#{setting}") })
      }
    }
    Rails.logger.debug("setting_for(#{setting})")
    Rails.logger.debug(options.inspect)
    json = HTTParty.post("#{DATA_SERVER}/v1", options)
    @search = JSON.parse(json.to_s, object_class: OpenStruct)
    @search.data.setting
  rescue => e
    Rails.logger.error("Error finding setting for: #{setting}")
    Rails.logger.error(e.message)
    'unknown'
  end
end
