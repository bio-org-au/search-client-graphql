class Plants::Names::SearchController < ApplicationController
  def index
    logger.debug(" Plants::Names::SearchController < ApplicationController")
    case params[:pc]
    when /all\z/
      redirect_to plants_names_search_all_path(q: params["q"], show_results_as: params["show_results_as"], pc: params[:pc])
    when /scientific\z/
      redirect_to plants_names_search_scientific_path(q: params["q"], show_results_as: params["show_results_as"], pc: params[:pc])
    when /cultivar\z/
      redirect_to plants_names_search_cultivar_path(q: params["q"], show_results_as: params["show_results_as"], pc: params[:pc])
    when /common\z/
      redirect_to plants_names_search_common_path(q: params["q"], show_results_as: params["show_results_as"], pc: params[:pc])
    end
  end

  private

  def set_zone
    @zone = "plants"
  end
end
