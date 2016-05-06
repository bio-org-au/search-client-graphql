class Plants::Names::Search::Within::Taxon::SelectedRanks::SearchController < ApplicationController
  def index
    @name = Name.find(params[:id])
    @descendants = Plants::Names::Descendants.new(params[:id])
    return unless params[:id].present?
    @descendants_at_ranks = Plants::Names::DescendantsAtRanks.new(params)
    render action: "index"
  end
end
