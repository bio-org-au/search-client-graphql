class Plants::NamesController < ApplicationController
  def show
    @name = Name.find_by(id: params[:id])
    #if params.key?(:target_id)
      @target_id = params[:target_id]
    #else
    #  @target_id = "name-#{@name.id}"
    #end
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
