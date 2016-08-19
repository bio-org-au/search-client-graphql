# frozen_string_literal: true
require "test_helper"

class NameAssociationsAcceptedNameSimpleTest < ActiveSupport::TestCase
  test "name association accepted name simple test" do
    name = names(:angophora_costata)
    assert_nothing_raised do
      accepted_name = name.accepted_name
    end
  end
end
