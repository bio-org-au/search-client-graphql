# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body, timeout: @client_request.timeout)
    Rails.logger.debug(json.to_s)
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def body
    { query: graphql_query_string }
  end

  def graphql_query_string
    if @client_request.just_count?
      AdvancedNamesController::Index::CountQuery.new(@client_request)
                                                 .query_string
    elsif @client_request.details?
      AdvancedNamesController::Index::DetailQuery.new(@client_request)
                                                 .query_string
    else
      AdvancedNamesController::Index::ListQuery.new(@client_request)
                                               .query_string
    end
  end
end
