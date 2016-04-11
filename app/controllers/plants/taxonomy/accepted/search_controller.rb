class Plants::Taxonomy::Accepted::SearchController < ApplicationController
  def index
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
