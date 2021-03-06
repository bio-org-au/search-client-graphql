# frozen_string_literal: true

# Controller
# Run a search
# Display a search form
# Run a search using the search term supplied
# Trim trailing spaces from the search term
# Form a request to the Graphql server
# Modify the request based on form fields for:
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
    @client_request = Index::ClientRequest.new(search_params, session[:editor] || false)
    if @client_request.any_type_of_search?
      @search_result = Index::GraphqlRequest.new(@client_request).result
    end
    render_index
  end

  def show
    @client_request = Show::ClientRequest.new(show_params)
    @raw_result = Show::GraphqlRequest.new(@client_request).result
    if @raw_result["data"]["name"].nil?
      render_no_such_record
    else
      render_show
    end
  end

  private

  def render_index
    respond_to do |format|
      format.html { render_index_html }
      format.json { render json: @search_result }
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

  def render_no_such_record
    @results = nil
    respond_to do |format|
      format.html { render :show_error }
      format.json { render json: nil }
    end
  end

  def render_index_html
    @page_title = "#{@name_label} Search"
    @results = Application::Names::Results.new(@search_result)
    render :index
  end

  def render_csv
    @results = Application::Names::Results.new(@search_result)
    render 'csv.html', layout: nil
  end

  def show_params
    params.permit(:id, :search_form)
  end

  def search_params
    params.permit(:utf8, :q, :format, :show_details, :show_family, :show_links,
                  :name_type, :limit, :count, :search, :list_or_count, :page,
                  :limit_per_page_for_list, :limit_per_page_for_details,
                  :cultivar_name, :common_name, :scientific_name, :per_page,
                  :sample_search_option_index)
  end
end
