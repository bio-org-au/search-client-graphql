#  Search for cultivar names
class Plants::Names::Search::Cultivar
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Cultivar Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Names::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    @results = name_search
  end

  def name_search
    if @parsed.list?
      list_search.search_for(@parsed.search_term)
    else
      detail_search.search_for(@parsed.search_term)
    end
  end

  def list_search
    Name.cultivar_search
        .joins(:name_tree_path_default)
        .includes(:name_tree_path_default)
        .joins(:name_type)
        .where(name_type: { cultivar: true })
        .order("trim( trailing '>' from substring(substring(name_tree_path.rank_path from 'Familia:[^>]*>') from 9)), sort_name")
        .limit(@parsed.limit)
  end

  def detail_search
    NameInstanceNameTreePath.cultivar.ordered
  end
end
