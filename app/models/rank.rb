# frozen_string_literal: true

# Get Ranks from the server.
class Rank
  DATA_SERVER = Rails.configuration.data_server

  def options
    if Rails.configuration.rank_options.blank?
      Rails.configuration.rank_options = server_rank_options
    else
      Rails.configuration.rank_options
    end
  end

  private

  def server_rank_options
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
