# frozen_string_literal: true

# Controller
class NamesController < ApplicationController

  def show
    @name = Name.find_by(id: params[:id])
    @name_reference_instance_set = NameReferenceInstanceSet.new(params[:id])
    @target_id = params[:target_id]
  end

  # Used for verification (i.e. testing) of changes via samples generated 
  # in the development environment.
  # It is the same as show but renders only the core data which is intended
  # to be diffed to check for unintended changes.
  def raw
    @name = Name.find_by(id: params[:id])
    @name_reference_instance_set = NameReferenceInstanceSet.new(params[:id])
    @target_id = params[:target_id]
    render :raw, layout: false
  end
end
