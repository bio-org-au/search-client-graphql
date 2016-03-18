class Plants::Names::Search::CultivarController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::Cultivar.new(params, default_show_results_as: session[:default_show_results_as])
    end
    render action: "index"
  end
end
