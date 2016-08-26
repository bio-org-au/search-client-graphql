# frozen_string_literal: true
#  Search for cultivar names
class Plants::Names::Search::Cultivar
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Cultivar Name"
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Names::Search::Parse.new(params,
                                               search_type: SEARCH_TYPE,
                                               default_show_results_as:
                                                 default_show_results_as)
    @results = name_search
  end

  def name_search
    list_search.search_for(@parsed.search_term)
  end

  def list_search
    Name.cultivar_search
        .joins(:name_tree_path_default)
        .includes(:name_tree_path_default)
        .joins(:name_type)
        .where(name_type: { cultivar: true })
        .ordered_scientifically
  end
end
