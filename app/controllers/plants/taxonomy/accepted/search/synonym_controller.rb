class Plants::Taxonomy::Accepted::Search::SynonymController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Taxonomy::Accepted::Search::Synonym.new(params, default_show_results_as: session[:default_show_results_as])
    end
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def set_zone
    @zone = "plants"
  end
end
