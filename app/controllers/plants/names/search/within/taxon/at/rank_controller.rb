# frozen_string_literal: true

module Plants::Names::Search::Within::Taxon::At
  # Controller
  class RankController < ApplicationController
    def index
      @name = Name.find(params[:id])
      @results = Plants::Names::DescendantsAtRank.new(params).results
    end
  end
end
