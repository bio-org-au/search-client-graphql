# frozen_string_literal: true
# Non-accepted taxonomies controller
class Taxonomy::OtherController < ApplicationController
  def index
    @taxonomies = Taxonomy::Other::TAXONOMIES
  end

  def show
    @taxonomies = Taxonomy::Other::TAXONOMIES
    @taxonomy = Taxonomy::Other.new(params[:id])
    render action: :index if @taxonomy.empty?
  end
end
