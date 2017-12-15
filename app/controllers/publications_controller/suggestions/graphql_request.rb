# frozen_string_literal: true

# Class extracted from publications controller.
class PublicationsController::Suggestions::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body,
                         timeout: @client_request.timeout)
    a = []
    JSON.parse(json.to_s, object_class: OpenStruct).data.publication_search.publications.each do | publication |
      a.push('citation')
    end
  end

  def body
    { query: graphql_query_string }
  end

  def graphql_query_string
    PublicationsController::Suggestions::ListQuery.new(@client_request)
                                                  .query_string
  end
end
