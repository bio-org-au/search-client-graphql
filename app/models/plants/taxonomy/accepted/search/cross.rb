#  Search for scientific names
class Plants::Taxonomy::Accepted::Search::Cross
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
    name_search.lower_simple_name_like(@parsed.search_term)
  end

  def full_name_search
    name_search.lower_full_name_like(@parsed.search_term)
  end

  def xname_search
    ApcSynonymVw.where(["lower(full_name) like lower(?)",@parsed.search_term])
                .order("rank_path, full_name")
  end

  def name_search
    Name.accepted_tree_synonyms
        #.joins(:name_type)
        #.includes(:rank)
  end
end
