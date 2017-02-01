# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchExcNamedHybridTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find excluded hybrid" do
    get :index,
        q: "excluded",
        search_type: "excluded",
        add_trailing_wildcard: "true"
    assert_response :success
    assert_select ".search-result-summary",
                  /2 names/,
                  "Summary should report 2 name"
  end
end
