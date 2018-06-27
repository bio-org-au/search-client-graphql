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
  def index
    @client_request = Index::ClientRequest.new(search_params)
    if @client_request.any_type_of_search?
      @search = @client_request.search
    end

    Rails.logger.debug("Before render")
    render_index
  end

  private

  def render_index
    respond_to do |format|
      format.html { render_index_html }
    end
  end

  def render_index_html
    @page_title = "#{@tree_label} Search"
    @results = TaxonomyController::Results.new(@search)
    render :index
  end

  def no_search
    @results = nil
    @search_term = nil
    render :index
  end

  def search_params
    params.permit(:utf8, :q, :format, :list_or_detail, :fuzzy_or_exact,
                  :taxon_type, :limit, :offset, :list_or_count, :show_links,
                  :limit_per_page_for_list, :limit_per_page_for_details,
                  :accepted_names, :excluded_names, :cross_references,
                  :show_synonyms, :show_distribution, :show_comments,
                  :sample_search_option_index)
  end
end
