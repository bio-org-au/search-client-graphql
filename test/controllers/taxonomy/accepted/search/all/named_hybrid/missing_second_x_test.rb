# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchAllNamedHybridMissing2ndXTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find one accepted x agro x again" do
    get :index,
        q: "x agro again",
        search_type: "all",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /1 name/,
                  "Summary should report 1 name"
  end
end
