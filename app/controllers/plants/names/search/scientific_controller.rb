class Plants::Names::Search::ScientificController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::Scientific.new(params)
    end
    #if @search.present? && @search.results.size == 1
      #@name = @search.results.first
      #render "/plants/names/show"
    #else
      render action: "index", stream: true
    #end
  end
end
