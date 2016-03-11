class Plants::Names::SearchController < ApplicationController
  def index
    #render controller: "Plants::Names::Search::AllController",
           #action: "search"
    redirect_to plants_names_search_all_path
  end
end
