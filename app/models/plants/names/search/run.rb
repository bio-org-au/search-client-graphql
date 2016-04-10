class Apni::Search::Run
  attr_reader :results
  SIMPLE_SEARCH = "APNI Search"

  def initialize(parsed)
    @results = Apni::Search::OnName::Simple.new(parsed).results
  end
end
