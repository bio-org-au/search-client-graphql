# frozen_string_literal: true

# Class extracted from name controller.
class Application::Show::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    throw('class Application::Show::GraphqlRequest')
    @client_request = client_request
  end

  def xresult
    throw 'result'
    response = HTTParty.post("#{DATA_SERVER}/v1", query)
    # Rails.logger.debug(response)
    JSON.parse(response.to_s, object_class: OpenStruct)
  end

  def xquery
    {
      body: {
        query: NamesController::Show::GraphqlQuery.new(@client_request)
                                                  .as_string
      }
    }
  end
end
