# frozen_string_literal: true
class Plants::Taxonomy::Accepted::SearchController < ApplicationController
  def index
    search if params["q"].present?
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def search
    case params[:search_type] || ""
    when /accepted\z/
      @search = Plants::Taxonomy::Accepted::Search::Accepted.new(params)
    when /accepted and excluded\z/
      @search = Plants::Taxonomy::Accepted::Search::AcceptedAndExcluded.new(params)
    when /all\z/
      @search = Plants::Taxonomy::Accepted::Search::All_.new(params)
    when /synonyms\z/
      @search = Plants::Taxonomy::Accepted::Search::Synonym.new(params)
    when /excluded\z/
      @search = Plants::Taxonomy::Accepted::Search::Excluded.new(params)
    else
      @search = Plants::Taxonomy::Accepted::Search::Accepted.new(params)
    end
  end

  def set_zone
    @zone = "plants"
  end
end
