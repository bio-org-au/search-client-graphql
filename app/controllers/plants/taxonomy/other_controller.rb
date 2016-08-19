# frozen_string_literal: true
# Non-accepted taxonomies controller
class Plants::Taxonomy::OtherController < ApplicationController
  def index
    @taxonomies = Plants::Taxonomy::Other::TAXONOMIES
  end

  def show
    @taxonomies = Plants::Taxonomy::Other::TAXONOMIES
    @taxonomy = Plants::Taxonomy::Other.new(params[:id])
    render action: :index if @taxonomy.empty?
  end

  private

  def set_zone
    @zone = "plants"
  end
end
