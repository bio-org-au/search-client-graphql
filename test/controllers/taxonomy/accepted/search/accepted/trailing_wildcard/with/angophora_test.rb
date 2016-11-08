# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchAccTrailWildCardWithAngophoraTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find one accepted angophora" do
    get :index,
        q: "angophora",
        search_type: "accepted",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /2 names/,
                  "Summary should report 2 names"
  end
end
