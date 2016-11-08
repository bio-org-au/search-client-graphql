# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class NamesSearchTrailWildcardWithoutAngophoraTest < ActionController::TestCase
  tests Names::SearchController
  test "should find angophora" do
    get :index, q: "angophora", add_trailing_wildcard: "false"
    assert_response :success
    assert_select ".search-result-summary",
                  /1 scientific name/,
                  "Summary should report 1 scientific name"
  end
end
