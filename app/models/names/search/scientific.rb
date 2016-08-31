# frozen_string_literal: true
#  Search for scientific names
class Names::Search::Scientific
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name"
  def initialize(params, default_show_results_as: "list")
    Rails.logger.debug("Name::Search::Scientific")
    @parsed = Names::Search::Parse.new(params,
                                       search_type: SEARCH_TYPE,
                                       default_show_results_as:
                                       default_show_results_as)
    Rails.logger.debug("@parsed.limit: #{@parsed.limit}")
    @results = name_search
  end

  def name_search
    list_search.search_for(@parsed.search_term)
  end

  def list_search
    Name.scientific_search
        .joins(:name_type)
        .joins(:name_tree_path_default)
        .includes(:name_tree_path_default)
        .where(name_type: { scientific: true })
        .ordered_scientifically
  end
end
