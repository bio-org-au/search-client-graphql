class Plants::Taxonomy::Accepted::SearchController < ApplicationController

  private

  def set_zone
    @zone = 'plants'
  end
end
