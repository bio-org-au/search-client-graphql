class Plants::Names::Search::ScientificController < ApplicationController
  def search
    if params["q"].present?
      @search = Apni::Search::OnName::Scientific.new(params)
    end
    #if @search.present? && @search.results.size == 1
      #@name = @search.results.first
      #render "/plants/names/show"
    #else
      render action: "index"
    #end
  end
end