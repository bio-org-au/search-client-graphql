# frozen_string_literal: true

#  Search for scientific names
class Taxonomy::Accepted::Search::AllOptions
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Accepted, Excluded, or Synonym"
  def initialize(params, default_show_results_as: "details")
    @parsed = Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as
    )
    @results = NameOrSynonym.name_matches(@parsed.search_term)
  end
end
