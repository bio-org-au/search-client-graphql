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
class SearchController < ApplicationController
  DATA_SERVER = Rails.configuration.data_server
  layout 'minimal'

  def index
    @search = nil
    @show_details = false
    if search_params['q'].present?
      search
    else
      no_search
    end
  end

  private

  def no_search
    @results = nil
    @search_term = nil
    render :index, layout: "minimal"
  end

  def search
    review_params
    request_string = if @show_details
                       "#{DATA_SERVER}/v1?query=#{detail_query}"
                     else
                       "#{DATA_SERVER}/v1?query=#{list_query}"
                     end
    logger.info("request_string: #{request_string}")
    json = HTTParty.get(request_string).to_json
    @search = JSON.parse(json, object_class: OpenStruct)
    present_results
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
    end
  rescue => e
    logger.error("Search error #{e} for params: #{params.inspect}")
    render :error
  end

  def present_html
    logger.info("client: present_info")
    @results = Results.new(@search)
    render :index
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
              name_status_name
            }
          }
      }
    HEREDOC
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
