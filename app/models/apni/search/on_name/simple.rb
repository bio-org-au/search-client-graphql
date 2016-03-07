class Apni::Search::OnName::Simple
  attr_reader :results
  def initialize(parsed)
    @results = Name.where(simple_name: parsed.search_term)
  end
end

