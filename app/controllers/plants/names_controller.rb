class Plants::NamesController < ApplicationController
  def show
    @name = Name.find_by(id: params[:id])
  end
end
