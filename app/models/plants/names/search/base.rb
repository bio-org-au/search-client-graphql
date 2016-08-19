# frozen_string_literal: true
class Plants::Names::Search::Base
  attr_reader :parsed,
              :ran
  def initialize(params)
    @parsed = Plants::Names::Search::Parse.new(params)
    @ran = Plants::Names::Search::Run.new(@parsed)
  end
end
