# frozen_string_literal: true

# Controller
class IncludeTaxonomyDetailsController < ApplicationController
  def toggle
    session[:taxonomy_details] ||= false
    session[:taxonomy_details] = !session[:taxonomy_details]
    render js: "changeTaxonomyDetailsSwitch(#{session[:taxonomy_details]});"
  end
end
