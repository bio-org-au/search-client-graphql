# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxAccSearchAccAngophoraNoTrailingWCTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find one accepted angophora" do
    get :index,
        q: "angophora",
        search_type: "accepted",
        add_trailing_wildcard: "false"
    assert_response :success
    assert_select ".search-result-summary",
                  /1 name/,
                  "Summary should report 1 name"
  end
end
