# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class NamesSearchNamedHybridSimpleTest < ActionController::TestCase
  tests Names::SearchController
  test "should find x agro" do
    get :index, q: "agro", add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /3 scientific names/,
                  "Summary should report 3 scientific names"
  end
end
