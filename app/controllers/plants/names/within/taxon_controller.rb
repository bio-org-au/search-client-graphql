class Plants::Names::Within::TaxonController < ApplicationController
  def index
    @name = Name.find(params[:id])
    #@search = Apni::Search::OnName::Within::Taxon.new(params)
    render action: "index"
  end
end
