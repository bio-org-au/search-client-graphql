# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class NamesSearchNamedHybridMissing2ndXXTest < ActionController::TestCase
  tests Names::SearchController
  test "should find x agro x again" do
    get :index, q: "x agro again", add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /1 scientific name/,
                  "Summary should report 1 scientific name"
  end
end
