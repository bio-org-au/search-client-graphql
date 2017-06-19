# frozen_string_literal: true

# Controller
class Taxonomy::DetailsController < ApplicationController
  def show_hide
    render plain: 'xxx'
  end

  def include_exclude
    session[:include_taxonomy_details] ||= false
    session[:include_taxonomy_details] = !session[:include_taxonomy_details]
    render js: "changeIncludeTaxonomyDetailsSwitch(#{session[:include_taxonomy_details]});"
  end

  def load
    @instance = Instance.find_by(id: params[:id])
  end
end
