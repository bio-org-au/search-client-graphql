class Plants::Names::Search::Within::TaxonController < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
