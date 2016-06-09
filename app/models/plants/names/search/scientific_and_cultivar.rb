#  Search for scientific and cultivar names
class Plants::Names::Search::ScientificAndCultivar
    attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: "list")
    Rails.logger.debug("Plants::Name::Search::Scientific")
    @parsed = Plants::Names::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    Rails.logger.debug("@parsed.limit: #{@parsed.limit}")
    @results = name_search
  end

  def name_search
    if @parsed.list?
      list_search.search_for(@parsed.search_term)
    else
      list_search.search_for(@parsed.search_term)
      #detail_search.search_for(@parsed.search_term)
    end
  end

  def list_search
    Name.scientific_search
        .joins(:name_type)
        .joins(:name_tree_path_default)
        .includes(:name_tree_path_default)
        .where("name_type.scientific = true or name_type.cultivar = true")
        .ordered_scientifically
  end

  def detail_search
    NameInstanceNameTreePath.scientific.includes(:name).includes(:rank).ordered
  end
end
