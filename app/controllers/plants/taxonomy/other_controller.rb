class Plants::Taxonomy::OtherController < ApplicationController

  def index
    @taxonomies = Plants::Taxonomy::Other::TAXONOMIES
  end

  def show
    @taxonomies = Plants::Taxonomy::Other::TAXONOMIES
    @taxonomy = Plants::Taxonomy::Other.new(params[:id])
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
