# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::GraphqlRequest::NameSearch
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body, timeout: @client_request.timeout)
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def body
    { query: graphql_query_string }
  end

  def graphql_query_string
    if @client_request.just_count?
      CountQuery.new(@client_request).query_string
    elsif @client_request.details?
      DetailQuery.new(@client_request).query_string
    else
      ListQuery.new(@client_request).query_string
    end
  end
end