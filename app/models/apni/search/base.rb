class Apni::Search::Base
  attr_reader :parsed,
              :ran
  def initialize(params)
    @parsed = Apni::Search::Parse.new(params)
    @ran = Apni::Search::Run.new(@parsed)
  end
end
