# frozen_string_literal: true
class Plants::Names::Search::Within::Taxon::SelectedRanksController < ApplicationController
  def index
    @name = Name.find(params[:id])
    @descendants = Plants::Names::Descendants.new(params[:id])
    render action: "index"
  end
end
