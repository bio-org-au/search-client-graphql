# frozen_string_literal: true

# Controller
class TaxonomyController < ApplicationController
  def index
  end

  def show
    @name = Name.find_by(id: params[:id])
    @name_reference_instance_set = NameReferenceInstanceSet.new(params[:id]).results
    @target_id = params[:target_id]
  end
end
