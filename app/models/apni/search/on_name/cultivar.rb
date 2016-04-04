#  Search for cultivar names
class Apni::Search::OnName::Cultivar
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Cultivar Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Apni::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    name_search.lower_simple_name_like(@parsed.search_term)
  end

  def full_name_search
    name_search.lower_full_name_like(@parsed.search_term)
  end

  def name_search
    Name.joins(:name_type)
        .where(name_type: { cultivar: true })
        .not_a_duplicate
        .order(:full_name)
  end
end
