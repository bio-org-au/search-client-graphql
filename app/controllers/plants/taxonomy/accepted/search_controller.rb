class Plants::Taxonomy::Accepted::SearchController < ApplicationController
  def index
    if params["q"].present?
      search
    end
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def search
    case params[:search_type] || ''
    when /accepted\z/
      @search = Plants::Taxonomy::Accepted::Search::Accepted.new(params, default_show_results_as: session[:default_show_results_as])
    when /accepted and excluded\z/
      @search = Plants::Taxonomy::Accepted::Search::AcceptedAndExcluded.new(params, default_show_results_as: session[:default_show_results_as])
    when /all\z/
      @search = Plants::Taxonomy::Accepted::Search::All_.new(params, default_show_results_as: session[:default_show_results_as])
    when /synonyms\z/
      @search = Plants::Taxonomy::Accepted::Search::Synonym.new(params, default_show_results_as: session[:default_show_results_as])
    when /excluded\z/
      @search = Plants::Taxonomy::Accepted::Search::Excluded.new(params, default_show_results_as: session[:default_show_results_as])
    else
      @search = Plants::Taxonomy::Accepted::Search::Accepted.new(params, default_show_results_as: session[:default_show_results_as])
    end
  end

  def set_zone
    @zone = "plants"
  end
end
