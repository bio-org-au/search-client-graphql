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
    @client_request = AdvancedNamesController::Index::ClientRequest.new(search_params)
    if @client_request.search?
      @search = AdvancedNamesController::Index::GraphqlRequest.new(@client_request)
                                                              .result
    end
    render_index
  end

  private

  def render_index
    respond_to do |format|
      format.html { render_index_html }
      format.json { render json: @search }
      format.csv { present_csv }
    end
  #rescue => e
  #  logger.error("Search error #{e} for params: #{params.inspect}")
  #  render :error
  end

  def render_index_html
    @results = Application::Names::Results.new(@search)
    render :index
  end

  def present_csv
    @results = Results.new(@search)
    render 'csv.html', layout: nil
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
    params.permit(:utf8, :q, :format, :show_details, :show_family, :show_links,
                  :name_type, :limit, :author_abbrev, :family)
  end
end
