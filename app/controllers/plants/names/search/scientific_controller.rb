class Plants::Names::Search::ScientificController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::Scientific.new(params, default_show_results_as: session[:default_show_results_as])
    end
    #if @search.present? && @search.results.size == 1
      #@name = @search.results.first
      #render "/plants/names/show"
    #else
      render action: "index", stream: true
    #end
  end
end
