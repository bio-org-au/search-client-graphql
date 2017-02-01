# frozen_string_literal: true
#  Search for common names
class Names::Search::Common
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Common Name"
  def initialize(params, default_show_results_as: "list")
    @parsed = Names::Search::Parse.new(params,
                                       search_type: SEARCH_TYPE,
                                       default_show_results_as:
                                       default_show_results_as)
    @results = name_search
  end

  def name_search
    Rails.logger.debug("common simple_name_search")
    if @parsed.list?
      Rails.logger.debug("common simple_name_search for list")
      list_search.search_for(@parsed.search_term)
    else
      Rails.logger.debug("common simple_name_search for details")
      detail_search.search_for(@parsed.search_term)
    end
  end

  def list_search
    Name.common_search
        .joins(:name_type)
        .where(name_type: { name: %w(common informal) })
  end

  def detail_search
    NameInstance.common.ordered
  end
end
