# frozen_string_literal: true
#  Search all names
class Plants::Names::Search::All_
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "All Name"
  def initialize(params, default_show_results_as: "list")
    Rails.logger.debug("Plants::Names::Search::All_")
    @parsed = Plants::Names::Search::Parse.new(params,
                                               search_type: SEARCH_TYPE,
                                               default_show_results_as:
                                                 default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    Rails.logger.debug("simple_name_search")
    if @parsed.list?
      list_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    else
      detail_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    end
  end

  def full_name_search
    Rails.logger.debug("full_name_search")
    if @parsed.list?
      list_search.simple_name_list_search(@parsed.search_term)
    else
      detail_search.full_name_allow_for_hybrids_like(@parsed.search_term)
    end
  end

  def list_search
    Name.all_search
  end

  def full_name_search
    name_search.lower_full_name_allow_for_hybrids_like(@parsed.search_term)
  end

  def detail_search
    NameInstance.ordered
  end
end
