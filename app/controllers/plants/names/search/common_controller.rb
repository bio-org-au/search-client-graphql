class Plants::Names::Search::CommonController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::Common.new(params, default_show_results_as: session[:default_show_results_as])
    end
    render action: "index"
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
