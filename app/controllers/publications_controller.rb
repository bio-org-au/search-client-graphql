# frozen_string_literal: true

class PublicationsController < ApplicationController
  def xsuggestions
    render json: [{ value: 'a', id: 1 }, { value: 'aza', id: 2 }, { value: 'agea', id: 3 }]
  end

  def suggestions
    client_request = PublicationsController::Suggestions::ClientRequest.new(search_params)
    if client_request.any_type_of_search?
      results = PublicationsController::Suggestions::GraphqlRequest.new(client_request)
                                                                   .result
    end
    render json: results.collect(&:citation)
  end

  private

  def search_params
    params.permit(:search_term, :format)
  end
end
