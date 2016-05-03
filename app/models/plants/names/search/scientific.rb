#  Search for scientific names
class Plants::Names::Search::Scientific
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Names::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    if @parsed.list?
      list.lower_simple_name_like(@parsed.search_term)
    else
      details.simple_name_like(@parsed.search_term)
    end
  end

  def full_name_search
    name_search.lower_full_name_like(@parsed.search_term)
  end

  def list
    Name.scientific_search
        .joins(:name_type)
        .where(name_type: { scientific: true })
  end

  def details
    NameInstance.scientific.ordered
  end

  def name_search
    Name.scientific_search
        .joins(:name_type)
        .where(name_type: { scientific: true })
  end
end
