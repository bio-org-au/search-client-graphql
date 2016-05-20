# Search across all names.
class Plants::Names::Search::AllController < ApplicationController
  # Scientific/cultivar names are different from common names
  # e.g. have/don't have name_tree_path entry
  # and cannot be sensibly intersorted.  
  # Have resorted to two searches.
  def index
    if params["q"].present?
      logger.debug("searching all")
      @search = Plants::Names::Search::All_.new(params, default_show_results_as: session[:default_show_results_as])
    end
    params[:show_results_as] = session[:default_show_results_as] unless params.has_key?(:show_results_as)
    render action: "index"
  end

  private

  def set_zone
    @zone = "plants"
  end
end
