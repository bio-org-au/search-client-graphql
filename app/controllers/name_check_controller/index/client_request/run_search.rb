# frozen_string_literal: true

# Class extracted from name controller.
class NameCheckController::Index::ClientRequest::RunSearch
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body, timeout: 50)
    Rails.logger.error(json.to_s)  if json.to_s =~ /error/
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def body
    Rails.logger.debug(graphql_query_string)
    { query: graphql_query_string }
  end

  def graphql_query_string
    Query.new(@client_request).query_string
  end
end
