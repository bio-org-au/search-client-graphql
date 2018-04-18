# frozen_string_literal: true

# Controller
class NameCheckController < ApplicationController
  def index
    @page_title = "Name Check"
    @client_request = Index::ClientRequest.new(search_params)
    @wrapped_search_results = Results.new(@client_request.search_results)
  end

  private

  def search_params
    params.permit(:utf8, :q, :controller, :action, :list_or_tabular, :limit,
                  :show_links)
  end
end
