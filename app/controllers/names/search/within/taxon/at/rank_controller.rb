# frozen_string_literal: true

module Names::Search::Within::Taxon::At
  # Controller
  class RankController < ApplicationController
    def index
      @name = Name.find(params[:id])
      @results = Names::DescendantsAtRank.new(params).results
    end
  end
end
