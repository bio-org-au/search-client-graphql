# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyAcceptedSearchExcludedTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find an excluded name" do
    get :index, q: "*", search_type: "excluded"
    assert_response :success
  end
end
