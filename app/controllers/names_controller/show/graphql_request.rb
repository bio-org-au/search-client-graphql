# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Show::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    response = HTTParty.post("#{DATA_SERVER}/v1", query)
    Rails.logger.error(response.to_s)  unless response.code == 200
    JSON.parse(response.to_s, object_class: OpenStruct)
  end

  def query
    {
      body: {
        query: NamesController::Show::GraphqlQuery.new(@client_request)
                                                  .as_string
      }
    }
  end
end
