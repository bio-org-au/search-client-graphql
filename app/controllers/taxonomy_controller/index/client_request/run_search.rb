# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::RunSearch
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    Rails.logger.debug(self.class.name)
    @client_request = client_request
  end

  def result
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body_of_post,
                         timeout: @client_request.timeout)
    debug('=============**********************************')
    debug(response.to_s) 
    debug('=============**********************************')
    Rails.logger.error(json.to_s) if json.to_s =~ /error/
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def body_of_post
    Rails.logger.debug(graphql_query_string)
    { query: graphql_query_string }
  end

  def graphql_query_string
    if @client_request.just_count?
      CountQuery.new(@client_request).query_string
    elsif @client_request.details?
      DetailQuery.new(@client_request).query_string
    else
      Rails.logger.debug('ListQuery.new(@client_request).query_string')
      Rails.logger.debug(ListQuery.new(@client_request).query_string)
      ListQuery.new(@client_request).query_string
    end
  end

  private

  def debug(msg)
    Rails.logger.debug("TaxonomyController::Index::ClientRequest::RunSearch: #{msg}")
  end
end
