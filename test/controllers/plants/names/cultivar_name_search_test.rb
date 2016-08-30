# frozen_string_literal: true
require "test_helper"

# Test the Plants Name Search Controller.
class CultivarNameSearchTest < ActionController::TestCase
  tests Plants::Names::SearchController
  test "should search for cultivar names" do
    get :index, q: "a*", search_type: "cultivar"
    assert_response :success
  end
end
