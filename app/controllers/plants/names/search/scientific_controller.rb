class Plants::Names::Search::ScientificController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::Scientific.new(params, default_show_results_as: session[:default_show_results_as])
    end
    render action: "index", stream: true
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
