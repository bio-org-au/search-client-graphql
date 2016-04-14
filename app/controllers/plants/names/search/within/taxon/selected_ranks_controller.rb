class Plants::Names::Search::Within::Taxon::SelectedRanksController < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
