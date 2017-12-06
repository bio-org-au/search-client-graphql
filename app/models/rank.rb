# frozen_string_literal: true

# Get Ranks from the server.
class Rank
  DATA_SERVER = Rails.configuration.data_server

  def options
    @options ||= rank_options
  end

  private

  def rank_options
    ranks = {
      body: {
        query: "{ranks {options} }"
      }
    }
    json = HTTParty.post("#{DATA_SERVER}/v1", ranks)
    search = JSON.parse(json.to_s, object_class: OpenStruct)
    search.data.ranks.options
  end
end

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

