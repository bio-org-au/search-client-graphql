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
class TaxonomyController < ApplicationController
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
      body: { query: query_string }
    }
    logger.debug(options.inspect)
    json = HTTParty.post("#{DATA_SERVER}/v1.json", options)
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
    @type_of_name = search_params[:taxon_type]
    @fuzzy_or_exact = search_params[:fuzzy_or_exact]
    @limit = search_params[:limit]
    @show_details = search_params[:list_or_detail] == 'detail'
    @list_only = !@show_details
  end

  def present_results
    logger.info('client:  present_results')
    respond_to do |format|
      format.html { present_html }
      format.json { render json: @search }
    end
    # rescue => e
    # logger.error("Search error #{e} for params: #{params.inspect}")
    # render :error
  end

  def present_html
    logger.info('client: present_info')
    @taxa = @search.data.taxonomy_search.taxa
    render :index
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
                  .sub(/search_term_placeholder/, CGI.escape(@search_term))
                  .sub(/"limit_placeholder"/, CGI.escape(@limit))
  end

  def list_query_raw
    <<~HEREDOC
      {
        taxonomy_search(search_term: "search_term_placeholder",
                        limit: "limit_placeholder")
          {
            taxa
            {
              id,
              full_name,
              name_status_name,
              reference_citation
            }
          }
      }
    HEREDOC
  end

  def detail_query_for_post
    detail_query_raw.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @search_term)
                    .sub(/"limit_placeholder"/, @limit)
  end

  def detail_query
    detail_query_raw.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, CGI.escape(@search_term))
                    .sub(/"limit_placeholder"/, CGI.escape(@limit))
  end

  def detail_query_raw
    <<~HEREDOC
      {
        taxonomy_search(search_term: "search_term_placeholder",
                        limit: "limit_placeholder")
        {
          taxa
          {
            id,
            full_name,
            name_status_name,
            reference_citation,
            taxon_details {
              instance_id,
              taxon_synonyms {
                id,
                name_id,
                full_name
              }
              taxon_distribution,
              taxon_comment
            }
          }
        }
      }
    HEREDOC
  end

  def search_params
    params.permit(:utf8, :q, :format, :list_or_detail, :fuzzy_or_exact,
                  :taxon_type, :limit)
  end
end
