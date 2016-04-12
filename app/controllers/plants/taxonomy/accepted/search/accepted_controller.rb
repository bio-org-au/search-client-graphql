class Plants::Taxonomy::Accepted::Search::AcceptedController < ApplicationController
  def index
    if params["q"].present?
      @search = Plants::Taxonomy::Accepted::Search::Accepted.new(params, default_show_results_as: session[:default_show_results_as])
    end
    render action: "index", stream: true
  end

  private

  def set_zone
    @zone = 'plants'
  end
end
