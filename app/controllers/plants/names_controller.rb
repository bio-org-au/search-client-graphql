class Plants::NamesController < ApplicationController
  def xshow
    #@name = Name.find_by(id: params[:id])
    @name = Name.includes(:status)
                .includes(:instances)
                .includes(:instance_types)
                .where(id: params[:id]).first
    @target_id = params[:target_id]
  end

  def show
    @name = Name.find_by(id: params[:id])
    @name_details = NameDetail.ordered.where(id: params[:id])
    @target_id = params[:target_id]
  end

  private

  def set_zone
    @zone = "plants"
  end
end
