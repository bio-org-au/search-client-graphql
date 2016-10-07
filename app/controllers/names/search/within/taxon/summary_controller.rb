# frozen_string_literal: true

# Rails controller
class Names::Search::Within::Taxon::SummaryController \
  < ApplicationController
  def index
    @name = Name.find(params[:id])
    render action: "index"
  end
end
