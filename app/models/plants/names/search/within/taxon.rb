class Plants::Names::Search::Within::Taxon
  attr_reader :parsed,
              :results
  def initialize(params)
    @parsed = Plants::Names::Search::Parse.new(params)
    @results = Name.joins(:name_rank).where(name_rank: {name: 'Genus'}).where(simple_name: @parsed.search_term)
  end
end

