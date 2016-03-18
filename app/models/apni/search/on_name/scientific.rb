#  Search for scientific names
class Apni::Search::OnName::Scientific
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name".freeze
  def initialize(params, default_show_results_as: 'list')
    @parsed = Apni::Search::Parse.new(params, search_type: SEARCH_TYPE, default_show_results_as: default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    name_search.where(["lower(simple_name) like lower(?)", @parsed.search_term])
  end

  def full_name_search
    name_search.where(["lower(full_name) like lower(?)", @parsed.search_term])
  end

  def name_search
    Name.joins(:name_type)
        .where(name_type: { scientific: true })
        .where(duplicate_of_id: nil)
        .order(:full_name)
  end
end

