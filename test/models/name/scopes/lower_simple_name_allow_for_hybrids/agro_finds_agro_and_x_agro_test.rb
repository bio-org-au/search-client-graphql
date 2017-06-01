# frozen_string_literal: true
require "test_helper"

# Test
class AgroFindsAgroAndXAgroTest < ActiveSupport::TestCase
  test "agro finds agro and x agro" do
    results = Name.simple_name_allow_for_hybrids_like("agro")
    assert results.pluck(:simple_name).include?("agro"),
          "Search for 'agro' should include 'agro'"
    assert results.pluck(:simple_name).include?("x agro"),
           "Search for 'agro' should include 'x agro'"
    assert_equal 2, results.size
  end
end
