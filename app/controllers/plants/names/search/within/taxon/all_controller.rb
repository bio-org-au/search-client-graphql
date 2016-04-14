class Plants::Names::Search::Within::Taxon::AllController < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
