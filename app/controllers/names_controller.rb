# frozen_string_literal: true

# Controller
class NamesController < ApplicationController
  def show
    @name = Name.find_by(id: params[:id])
    @name_details = NameDetail.ordered.where(id: params[:id])
    @target_id = params[:target_id]
  end
end
