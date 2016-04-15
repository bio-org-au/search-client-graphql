class Plants::Taxonomy::AcceptedController < ApplicationController
  def show
    @name = Name.find_by(id: params[:id])
    @target_id = params[:target_id]
  end

  private

  def set_zone
    @zone = "plants"
  end
end
