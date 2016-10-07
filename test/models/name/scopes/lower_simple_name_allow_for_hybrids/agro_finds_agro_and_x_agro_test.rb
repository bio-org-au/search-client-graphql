# frozen_string_literal: true
require "test_helper"

# Test
class NameScopesLSNAFHagro < ActiveSupport::TestCase
  test "agro finds agro and x agro" do
    results = Name.simple_name_allow_for_hybrids_like("agro")
    assert_equal 2, results.size
    assert results.pluck(:simple_name).include?("agro"), "Should include 'agro'"
    assert results.pluck(:simple_name).include?("x agro"),
           "Should include 'x agro'"
  end
end
