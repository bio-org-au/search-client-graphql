# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyAcceptedSearchAcceptedTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find an accepted name" do
    get :index, q: "*", search_type: "accepted"
    assert_response :success
  end
end
