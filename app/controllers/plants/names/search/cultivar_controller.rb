class Plants::Names::Search::CultivarController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Names::Search::Cultivar.new(params, default_show_results_as: session[:default_show_results_as])
    end
    render action: "index"
  end

  private

  def set_zone
    @zone = "plants"
  end
end
