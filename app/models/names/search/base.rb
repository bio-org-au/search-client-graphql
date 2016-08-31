# frozen_string_literal: true

# Rails model
class Names::Search::Base
  attr_reader :parsed,
              :ran
  def initialize(params)
    @parsed = Names::Search::Parse.new(params)
    @ran = Names::Search::Run.new(@parsed)
  end
end
