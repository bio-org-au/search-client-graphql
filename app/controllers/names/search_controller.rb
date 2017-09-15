# frozen_string_literal: true

# Controller
class Names::SearchController < ApplicationController
  DATA_SERVER = 'http://localhost:8083/nsl/ssg'
  def index
    logger.info("request_fred")
    request_string = "#{DATA_SERVER}/v1?query=fred"
    logger.info("request_string: #{request_string}")
    logger.info("partying")
    json = HTTParty.get(request_string).to_json
    logger.info("after partying... parsing....")
    @search = JSON.parse(json, object_class: OpenStruct)
    logger.info("after parsing.... about to present results")
    render json: @search
  end
end
