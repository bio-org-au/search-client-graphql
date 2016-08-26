# frozen_string_literal: true

module Plants::Names::Search::Within::Taxon::SelectedRanks
  # Controller
  class SearchController < ApplicationController
    def index
      @name = Name.find(params[:id])
      @descendants = Plants::Names::Descendants.new(params[:id])
      @descendants_at_ranks = Plants::Names::DescendantsAtRanks.new(params)
    end
  end
end
