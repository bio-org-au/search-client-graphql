# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyAcceptedSearchAcceptedAndExcludedTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find a accepted or excluded name" do
    get :index, q: "*", search_type: "excluded and excluded"
    assert_response :success
  end
end
