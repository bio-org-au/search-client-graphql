# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchSynNamedHybridMissing2ndXTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find synonym hybrid" do
    get :index,
        q: "synonym again",
        search_type: "synonyms",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /1 name/,
                  "Summary should report 1 name"
  end
end
