class Plants::Names::Search::AllController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Names::Search::TheLot.new(params, default_show_results_as: session[:default_show_results_as])
    end
    params[:show_results_as] = session[:default_show_results_as] unless params.has_key?(:show_results_as)
    render action: "index"
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
