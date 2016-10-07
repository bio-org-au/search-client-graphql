# frozen_string_literal: true

# Controller
class Taxonomy::Accepted::SearchController < ApplicationController
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
    case params[:search_type]
    when /^acc/
      search_a
    else
      search_b
    end
  end

  def search_a
    case params[:search_type]
    when /accepted\z/
      @search = Taxonomy::Accepted::Search::Accepted.new(params)
    when /accepted and excluded\z/
      @search = Taxonomy::Accepted::Search::AcceptedAndExcluded
                .new(params)
    else
      @search = Taxonomy::Accepted::Search::Accepted.new(params)
    end
  end

  def search_b
    @search = case params[:search_type]
              when /all\z/
                Taxonomy::Accepted::Search::AllOptions.new(params)
              when /synonyms\z/
                Taxonomy::Accepted::Search::Synonym.new(params)
              when /excluded\z/
                Taxonomy::Accepted::Search::Excluded.new(params)
              else
                Taxonomy::Accepted::Search::Accepted.new(params)
              end
  end
end
