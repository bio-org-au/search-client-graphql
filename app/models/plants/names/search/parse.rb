# frozen_string_literal: true
class Plants::Names::Search::Parse
  attr_reader :search_type,
              :search_term,
              :show_as,
              :limit

  SIMPLE_SEARCH = "Search"
  SHOW_DETAILS = "details"
  SHOW_LIST = "list"
  DEFAULT_LIST_LIMIT = 1000
  DEFAULT_DETAILS_LIMIT = 3

  def initialize(params, info = {})
    @search_type = if info.key?(:search_type)
                     "#{info[:search_type]} Search"
                   else
                     SIMPLE_SEARCH
                   end
    @search_term = params[:q].strip.tr("*", "%")
    @show_as = params[:show_results_as] || info[:default_show_results_as] || SHOW_LIST
    @limit = calculated_limit
  end

  def list?
    @show_as == SHOW_LIST
  end

  def show_list?
    list?
  end

  def details?
    @show_as == SHOW_DETAILS
  end

  def show_details?
    details?
  end

  def calculated_limit
    if list?
      DEFAULT_LIST_LIMIT
    else
      DEFAULT_DETAILS_LIMIT
    end
  end
end
