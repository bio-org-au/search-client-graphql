# frozen_string_literal: true

# Controller
# Run a search
# Display a search form
# Run a search using the search term supplied
# Trim trailing spaces from the search term
# Form a request to the Graphql server
# Modify the request based on form fields for:
# - list/details (ToDo)
# - auto wildcards/exact search (ToDo)
# - output format (ToDo)
# urlencode the search term
# Handle html format
# Handle json format
# ToDo: handle csv format
# Show useful error diagnostics
# - in log
# - on page
class NamesController < ApplicationController
  def index
    @client_request = Index::ClientRequest.new(search_params)
    if @client_request.any_type_of_search?
      @search = Index::GraphqlRequest.new(@client_request)
                                                      .result
    end
    render_index
  end

  def show
    @client_request = Show::ClientRequest.new(show_params)
    @raw_result = Show::GraphqlRequest.new(@client_request)
                                                       .result
    render_show
  end

  private

  def render_index
    respond_to do |format|
      format.html { render_index_html }
      format.json { render json: @search }
      format.csv { render_csv }
    end
  end

  # Present the name details in a structure that suits the name_detail partial.
  def render_show
    @results = OpenStruct.new
    @results.names =
      [Application::Names::Results::Name.new(@raw_result.data.name)]
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @raw_result.data.name }
    end
  end

  def render_index_html
    @results = Application::Names::Results.new(@search)
    render :index
  end

  def render_csv
    @results = Application::Names::Results.new(@search)
    render 'csv.html', layout: nil
  end

  def show_params
    params.permit(:id)
  end

  def search_params
    params.permit(:utf8, :q, :format, :show_details, :show_family, :show_links,
                  :name_type, :limit, :count, :search, :list_or_count, :offset,
                  :limit_per_page_for_list, :limit_per_page_for_details)
  end
end
