# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyAcceptedSearchMisappliedCassiniaTest < ActionController::TestCase
  tests Plants::Taxonomy::Accepted::SearchController
  test "should find cassinia misapplication" do
    get :index, q: "Cassinia*", search_type: "accepted"
    assert_response :success
  end
end
