#  Search all names
class Apni::Search::OnName::TheLot
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "All Name".freeze
  def initialize(params)
    @parsed = Apni::Search::Parse.new(params, search_type: SEARCH_TYPE)
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
    Name.where(duplicate_of_id: nil)
        .order(:full_name)
  end
end
