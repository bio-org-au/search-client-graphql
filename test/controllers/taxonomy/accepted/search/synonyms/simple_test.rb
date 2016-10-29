# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyAcceptedSearchSynonymsTest < ActionController::TestCase
  tests Taxonomy::Accepted::SearchController
  test "should find synonym" do
    get :index, q: "*", search_type: "synonym"
    assert_response :success
  end
end
