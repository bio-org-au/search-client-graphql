# frozen_string_literal: true
require "test_helper"

# Simple Test
class NameCMASFullNameAllowForHybridsLikeSimpleTest < ActiveSupport::TestCase
  test "name class methods as scopes name allow for hybrids like simple" do
    result = Name.full_name_allow_for_hybrids_like("angophora%")
    assert_not result.empty?, "Should get result for angophora%"
    assert_match "Angophora costata (Gaertn.) Britten",
                 result.first.full_name,
                 "First result should be Angophora costata (Gaertn.) Britten"
  end
end
