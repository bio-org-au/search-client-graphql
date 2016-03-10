class Apni::Search::OnName::Scientific
# Cannot call this "All", causes error.
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Scientific Name"
  def initialize(params)
    @parsed = Apni::Search::Parse.new(params, search_type: SEARCH_TYPE)
    @results = Name.where(["lower(simple_name) like lower(?)",
                           @parsed.search_term])
      .joins(:name_type)
      .where(name_type: { scientific: true })
      .order(:full_name)
    if @results.size == 0
      @results = Name.where(["lower(full_name) like lower(?)",
                             @parsed.search_term])
      .joins(:name_type)
      .where(name_type: { scientific: true })
      .order(:full_name)
    end
  end
end

