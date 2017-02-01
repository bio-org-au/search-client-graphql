# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchSynNamedHybridTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find synonym hybrid" do
    get :index,
        q: "synonym",
        search_type: "synonyms",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /2 name/,
                  "Summary should report 2 names"
  end
end
