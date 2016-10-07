# frozen_string_literal: true
require "test_helper"

# Simple Test for Name Associations Accepted Name
class NameAssociationsAcceptedNameSimpleTest < ActiveSupport::TestCase
  test "name association accepted name simple test" do
    name = names(:angophora_costata)
    assert_nothing_raised do
      name.accepted_name
    end
  end
end
