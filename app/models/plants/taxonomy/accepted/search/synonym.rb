#  Search for scientific names
class Plants::Taxonomy::Accepted::Search::Synonym
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Taxonomy::Accepted::Search::Parse.new(
      params,
      search_type: SEARCH_TYPE,
      default_show_results_as:
      default_show_results_as)
    @results = simple_name_search
    #@results = simple_name_search
    #return unless @results.empty?
    #@results = full_name_search
  end

  def simple_name_search
    AcceptedSynonym.simple_name_like(@parsed.search_term).default_ordered
  end

  def full_name_search
    AcceptedSynonym.full_name_like(@parsed.search_term).default_ordered
  end
end
