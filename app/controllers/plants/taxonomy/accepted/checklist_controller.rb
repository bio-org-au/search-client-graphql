class Plants::Taxonomy::Accepted::ChecklistController < ApplicationController

  private

  def set_zone
    @zone = 'plants'
  end
end
