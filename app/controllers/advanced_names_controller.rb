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
    logger.debug('index')
    @search = nil
    @show_details = false
    logger.debug('before if')
    if search_required?
      search_as_post
    else
      logger.debug('no q')
      # @search_term = search_link_params['q']
      @link_params = params['link_params']
      no_search
    end
  end

  private

  def search_required?
    search_params['q'].present? ||
      search_params['author_abbrev'].present? ||
      search_params['family'].present?
  end

  def no_search
    logger.debug('no search')
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
    logger.debug(options.inspect)
    json = HTTParty.post("#{DATA_SERVER}/v1", options)
    @search = JSON.parse(json.to_s, object_class: OpenStruct)
    present_results
  end

  def query_string
    review_params
    if @show_details
      detail_query
    else
      list_query_for_post
    end
  end

  def review_params
    @search_term = search_params[:q].gsub(/ *$/, '')
    @author_abbrev = search_params[:author_abbrev].gsub(/ *$/, '')
    @family = search_params[:family].gsub(/ *$/, '')
    @type_of_name = search_params[:name_type]
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
      format.csv { present_csv }
    end
  #rescue => e
  #  logger.error("Search error #{e} for params: #{params.inspect}")
  #  render :error
  end

  def present_html
    logger.info('client: present_info')
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
                  .sub(/author_abbrev_placeholder/, @author_abbrev)
                  .sub(/family_placeholder/, @family)
                  .sub(/type_of_name_placeholder/, @type_of_name)
                  .sub(/fuzzy_or_exact_placeholder/,
                       @fuzzy_or_exact)
                  .sub(/"limit_placeholder"/, @limit)
  end

  def list_query
    list_query_raw.delete(' ')
                  .delete("\n")
                  .sub(/search_term_placeholder/, CGI.escape(@search_term))
                  .sub(/type_of_name_placeholder/, CGI.escape(@type_of_name))
                  .sub(/fuzzy_or_exact_placeholder/,
                       CGI.escape(@fuzzy_or_exact))
                  .sub(/"limit_placeholder"/, CGI.escape(@limit))
  end

  def list_query_raw
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    author_abbrev: "author_abbrev_placeholder",
                    family: "family_placeholder",
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

  def detail_query
    detail_query_raw.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @search_term)
                    .sub(/author_abbrev_placeholder/, @author_abbrev)
                    .sub(/family_placeholder/, @family)
                    .sub(/type_of_name_placeholder/, @type_of_name)
                    .sub(/fuzzy_or_exact_placeholder/,
                         @fuzzy_or_exact)
                    .sub(/"limit_placeholder"/, @limit)
  end

  def detail_query_raw
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    author_abbrev: "author_abbrev_placeholder",
                    family: "family_placeholder",
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
                  :name_type, :limit, :author_abbrev, :family)
  end
end
