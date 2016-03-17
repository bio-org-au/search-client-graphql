class Plants::Names::SearchController < ApplicationController
  def index
    case params[:pc]
    when /all\z/
      redirect_to plants_names_search_all_path(q: params['q'], look_at: params['look_at'], pc: params[:pc])
    when /scientific\z/
      redirect_to plants_names_search_scientific_path(q: params['q'], look_at: params['look_at'], pc: params[:pc])
    when /cultivar\z/
      redirect_to plants_names_search_cultivar_path(q: params['q'], look_at: params['look_at'], pc: params[:pc])
    when /common\z/
      redirect_to plants_names_search_common_path(q: params['q'], look_at: params['look_at'], pc: params[:pc])
    end
  end
end
