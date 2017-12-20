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
class AdvancedNamesController < ApplicationController
  DATA_SERVER = Rails.configuration.data_server

  def index
    @client_request = Index::ClientRequest.new(search_params).build_request
    @search = @client_request.search
    render_index
  end

  def show
    @client_request = NamesController::Show::ClientRequest.new(show_params)
    @name = NamesController::Show::GraphqlRequest.new(@client_request).result
    render_show
  end

  private

  def render_index
    respond_to do |format|
      format.html { render_index_html }
      format.js { render_index_html }
      format.json { render json: @search }
      format.csv { render_csv }
    end
  end

  def render_show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @name }
    end
  end

  def render_index_html
    if @client_request.name_search? 
      @results = Application::Names::Results.new(@search)
    elsif @client_request.publication_search? 
      @results = Application::Publications::Results.new(@search)
    end
    render :index
  end

  def render_csv
    @results = Application::Names::Results.new(@search)
    render 'csv.html', layout: nil
  end

  def search_params
    params.permit(:utf8, :list, :q, :requested_format, :show_details,
                  :show_family, :show_links, :name_type, :limit, :offset,
                  :taxon_name_author_abbrev, :basionym_author_abbrev, :family,
                  :genus, :rank, :species, :publication, :protologue,
                  :name_element, :search, :count)
  end
end
