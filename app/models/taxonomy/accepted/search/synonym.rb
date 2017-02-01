# frozen_string_literal: true
#  Search for scientific names
class Taxonomy::Accepted::Search::Synonym
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name"
  def initialize(params, default_show_results_as: "list")
    @parsed = Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as
    )
    @results = AcceptedSynonym.name_matches(@parsed.search_term).default_ordered
  end
end
