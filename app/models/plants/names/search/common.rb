# frozen_string_literal: true
#  Search for common names
class Plants::Names::Search::Common
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Common Name"
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Names::Search::Parse.new(params,
                                               search_type: SEARCH_TYPE,
                                               default_show_results_as:
                                                 default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    Rails.logger.debug("common simple_name_search")
    if @parsed.list?
      Rails.logger.debug("common simple_name_search for list")
      list_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    else
      Rails.logger.debug("common simple_name_search for details")
      detail_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    end
  end

  def full_name_search
    Rails.logger.debug("common full_name_search")
    if @parsed.list?
      Rails.logger.debug("common full_name_search for list")
      list_search.full_name_allow_for_hybrids_like(@parsed.search_term)
    else
      Rails.logger.debug("common full_name_search for details")
      detail_search.full_name_allow_for_hybrids_like(@parsed.search_term)
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
