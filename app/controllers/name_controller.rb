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
    @show_details = false
    if search_params['q'].present?
      search_as_post
    else
      no_search
    end
  end

  private

  def no_search
    @results = nil
    @search_term = nil
    render :index
  end

  def search_as_post
    options = {
                body: {
                  query: query_string
                      }
              }
    json = HTTParty.post("#{DATA_SERVER}/v1",options)
    @search = JSON.parse(json.to_s, object_class: OpenStruct)
    present_results
  end

  def query_string
    review_params
    if @show_details
      detail_query_for_post
    else
      list_query_for_post
    end
  end

  def review_params
    @search_term = search_params[:q].gsub(/ *$/, '')
    @type_of_name = search_params[:name_type]
    @fuzzy_or_exact = search_params[:fuzzy_or_exact]
    @limit = search_params[:limit]
    @show_details = search_params[:list_or_detail] == 'detail'
    @list_only = !@show_details
  end

  def present_results
    logger.info("client:  present_results")
    respond_to do |format|
      format.html { present_html }
      format.json { render json: @search }
      format.csv { present_csv }
    end
  # rescue => e
  #   logger.error("Search error #{e} for params: #{params.inspect}")
  #   render :error
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

  def list_query_for_post
    list_query_raw.delete(' ')
                  .delete("\n")
                  .sub(/search_term_placeholder/, @search_term)
                  .sub(/type_of_name_placeholder/, @type_of_name)
                  .sub(/fuzzy_or_exact_placeholder/,
                       @fuzzy_or_exact)
                  .sub(/"limit_placeholder"/, @limit)
  end

  def list_query
    list_query_raw.delete(' ')
                  .delete("\n")
                  .sub(/search_term_placeholder/, URI.escape(@search_term))
                  .sub(/type_of_name_placeholder/, URI.escape(@type_of_name))
                  .sub(/fuzzy_or_exact_placeholder/,
                       URI.escape(@fuzzy_or_exact))
                  .sub(/"limit_placeholder"/, URI.escape(@limit))
  end

  def list_query_raw
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    type_of_name: "type_of_name_placeholder",
                    fuzzy_or_exact: "fuzzy_or_exact_placeholder",
                    limit: "limit_placeholder")
          {
            names
            {
              id,
              full_name,
              name_status_name,
              family_name
            }
          }
      }
    HEREDOC
  end

  def detail_query_for_post
    detail_query_raw.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @search_term)
                    .sub(/type_of_name_placeholder/, @type_of_name)
                    .sub(/fuzzy_or_exact_placeholder/,
                         @fuzzy_or_exact)
                    .sub(/"limit_placeholder"/, @limit)
  end

  def detail_query
    detail_query_raw.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, URI.escape(@search_term))
                    .sub(/type_of_name_placeholder/, URI.escape(@type_of_name))
                    .sub(/fuzzy_or_exact_placeholder/,
                         URI.escape(@fuzzy_or_exact))
                    .sub(/"limit_placeholder"/, URI.escape(@limit))
  end

  def detail_query_raw
    <<~HEREDOC
    {
      name_search(search_term: "search_term_placeholder",
                  type_of_name: "type_of_name_placeholder",
                  fuzzy_or_exact: "fuzzy_or_exact_placeholder",
                  limit: "limit_placeholder")
      {
        names
        {
          id,
          simple_name,
          full_name,
          full_name_html,
          name_status_name,
          family_name,
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
    }
    HEREDOC
  end

  def search_params
    params.permit(:utf8, :q, :format, :list_or_detail, :fuzzy_or_exact,
                  :name_type, :limit)
  end
end
