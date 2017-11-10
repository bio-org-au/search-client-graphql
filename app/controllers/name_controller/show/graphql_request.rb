# frozen_string_literal: true

# Class extracted from name controller.
class NameController::Show::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1", query)
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def query
    {
      body: {
        query: NameController::Show::GraphqlQuery.new(@client_request).as_string
      }
    }
  end
end
