# frozen_string_literal: true

# Controller
class NameCheckController < ApplicationController
  def index
    @client_request = Index::ClientRequest.new(search_params)
    if @client_request.any_type_of_search?
      Rails.logger.debug('there is a search')
      @wrapped_search_results = Results.new(@client_request.search_results)
      Rails.logger.debug("@wrapped_search_results class: #{@wrapped_search_results.class}")
    end
  end

  private

  def search_params
    params.permit(:utf8, :q, :controller, :action, :list_or_tabular)
  end
end
