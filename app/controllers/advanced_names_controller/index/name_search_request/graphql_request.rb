# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::GraphqlRequest
  DATA_SERVER = Rails.configuration.data_server
  def initialize(client_request)
    @client_request = client_request
  end

  def xresult
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body, timeout: @client_request.timeout)
    Rails.logger.error(json.to_s) if json.to_s =~ /error/
    JSON.parse(json.to_s, object_class: OpenStruct)
  end

  def result
    response = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body,
                         timeout: @client_request.timeout)
    Rails.logger.error(response.code) unless response.code == 200
    Rails.logger.error(response.to_s)  unless response.code == 200
    JSON.parse(response.to_s, object_class: OpenStruct)
  end

  def body
    AdvancedNamesController::Index::NameSearchRequest::GraphqlQuery.new(@client_request).query_body
  end

  private

  def debug(s)
    Rails.logger.debug("AdvancedNamesController::Index::NameSearchRequest::GraphqlRequest: #{s}")
  end
end
