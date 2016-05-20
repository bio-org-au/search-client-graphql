require "test_helper"

class NameScopesLSNAFH_mult_sym < ActiveSupport::TestCase
  test "multiply symbol works like x" do
    results = Name.simple_name_allow_for_hybrids_like("× agro")
    assert_equal 1, results.size 
    assert results.pluck(:simple_name).include?("x agro"), "Should include 'x agro'"
  end
end
