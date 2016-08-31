# frozen_string_literal: true

module Names::Search::Within::Taxon::SelectedRanks
  # Controller
  class SearchController < ApplicationController
    def index
      @name = Name.find(params[:id])
      @descendants = Names::Descendants.new(params[:id])
      @descendants_at_ranks = Names::DescendantsAtRanks.new(params)
    end
  end
end
