#  Search for scientific names
class Plants::Taxonomy::Accepted::Search::All_
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Taxonomy::Accepted::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    Name.accepted_tree_all_simple_name_search(@parsed.search_term)
  end
  def full_name_search
    Name.accepted_tree_all_full_name_search(@parsed.search_term)
  end
end
