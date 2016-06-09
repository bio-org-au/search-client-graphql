class Plants::Names::Search::ScientificAndCultivarController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Names::Search::ScientificAndCultivar.new(params)
    end
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def set_zone
    @zone = "plants"
  end
end
