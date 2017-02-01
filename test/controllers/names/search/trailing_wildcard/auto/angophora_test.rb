# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class NamesSearchTrailingWildcardAutoAngophoraTest < ActionController::TestCase
  tests Names::SearchController
  test "should find angophora" do
    get :index, q: "angophora", add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /2 scientific names/,
                  "Summary should report 2 scientific names"
  end
end
