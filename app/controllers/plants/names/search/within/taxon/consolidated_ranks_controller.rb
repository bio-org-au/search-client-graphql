class Plants::Names::Search::Within::Taxon::ConsolidatedRanksController < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
