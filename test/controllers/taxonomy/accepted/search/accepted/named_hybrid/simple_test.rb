# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchAccNamedHybridTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find one accepted x agro" do
    get :index,
        q: "agro",
        search_type: "accepted",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /3 names/,
                  "Summary should report 3 names"
  end
end
