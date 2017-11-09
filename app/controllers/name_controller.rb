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
class NameController < ApplicationController
  DATA_SERVER = Rails.configuration.data_server

  def index
    @search = nil
    @query_request = NameController::QueryRequest.new(search_params)
    if @query_request.search?
      search
    else
      no_search
    end
  end

  def show
    show_one
  end

  private

  def no_search
    @results = nil
    @search = nil
    @query_request = nil
    render :index
  end

  def search
    @graphql_request = GraphqlRequest.new(@query_request)
    json = HTTParty.post("#{DATA_SERVER}/v1", @graphql_request.query)
    @search = JSON.parse(json.to_s, object_class: OpenStruct)
    present_results
  end

  def show_one
    options = {
                body: {
                  query: show_query
                      }
              }
    json = HTTParty.post("#{DATA_SERVER}/v1", options)
    @name = JSON.parse(json.to_s, object_class: OpenStruct)
    show_name
  end

  def present_results
    logger.info("client:  present_results")
    respond_to do |format|
      format.html { present_html }
      format.json { render json: @search }
      format.csv { present_csv }
    end
   rescue => e
     logger.error("Search error #{e} for params: #{params.inspect}")
     render :error
  end

  def show_name
    logger.info("show_name")
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @name }
    end
   rescue => e
     logger.error("Search error #{e} for params: #{params.inspect}")
     render :error
  end

  def csv_data
    data = 'a,b,c' #@search.to_csv
    begin
      data = data.unicode_normalize(:nfc).encode("UTF-16LE")
      data = "\xFF\xFE".dup.force_encoding("UTF-16LE") + data
    rescue => encoding_error
      logger.error(encoding_error.to_s)
      logger.error("This CSV error in the SearchController does not")
      logger.error("prevent CSV data being created but it does indicate")
      logger.error("failure to encode the CSV as UTF-16LE")
    end
    data
  end

  def present_html
    @results = Results.new(@search)
    render :index
  end

  def present_csv
    @results = Results.new(@search)
    render 'csv.html', layout: nil
  end

  def show_query
    show_query_raw.delete(' ')
                  .delete("\n")
                  .sub(/id_placeholder/, show_params[:id])
  end

  def show_query_raw
    <<~HEREDOC
    {
      name(id: id_placeholder)
      {
          id,
          simple_name,
          full_name,
          full_name_html,
          family_name,
          name_status_name,
          name_history
          {
            name_usages
            {
              instance_id,
              reference_id,
              citation,
              page,
              page_qualifier,
              year,
              standalone,
              instance_type_name,
              primary_instance,
              misapplied,
              misapplied_to_name,
              misapplied_to_id,
              misapplied_by_id,
              misapplied_by_citation,
              misapplied_on_page,
              synonyms {
                id,
                full_name,
                instance_type,
                label,
                page,
                name_status_name,
              }
              notes {
                id,
                key,
                value
              }
            }
          }
        }
      }
    HEREDOC
  end

  def show_params
    params.permit(:id)
  end

  def search_params
    params.permit(:utf8, :q, :format, :show_details, :show_family, :show_links,
                  :fuzzy_or_exact, :name_type, :limit, :output_options)
  end
end
