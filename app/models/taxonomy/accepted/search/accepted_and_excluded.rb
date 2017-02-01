# frozen_string_literal: true
#  Search for scientific names
class Taxonomy::Accepted::Search::AcceptedAndExcluded
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name"
  def initialize(params, default_show_results_as: "details")
    @parsed = Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as
    )
    @results = search.name_matches(@parsed.search_term)
  end

  def search
    AcceptedName.ordered
                .includes(:status)
                .includes(:reference)
                .includes(:rank)
  end
end
