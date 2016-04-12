class Plants::Names::Search::Within::Taxon::RanksController < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
