# frozen_string_literal: true

#  Search for scientific names
class Plants::Taxonomy::Accepted::Search::AllOptions
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name"
  def initialize(params, default_show_results_as: "details")
    @parsed = Plants::Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as
    )
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    NameOrSynonym.simple_name_like(@parsed.search_term)
  end

  def full_name_search
    NameOrSynonym.full_name_like(@parsed.search_term)
  end
end
