class Apni::Search::OnName::Simple
  attr_reader :parsed,
              :results
  def initialize(params)
    @parsed = Apni::Search::Parse.new(params)
    #@results = Name.where(simple_name: @parsed.search_term)
    @results = Name.where(["lower(simple_name) like lower(?)",@parsed.search_term]).order(:full_name)
  end
end

