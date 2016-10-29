# frozen_string_literal: true

# Controller
class Names::SearchController < ApplicationController
  def index
    search if params["q"].present?
    respond_to do |format|
      format.html
      format.json { render json: @search }
      format.csv
    end
  end

  private

  def search
    @search = case params[:search_type]
              when /scientific-and-cultivar\z/
                Names::Search::ScientificAndCultivar.new(params)
              when /cultivar\z/
                Names::Search::Cultivar.new(params)
              when /common\z/
                Names::Search::Common.new(params)
              else
                Names::Search::Scientific.new(params)
              end
  end
end
