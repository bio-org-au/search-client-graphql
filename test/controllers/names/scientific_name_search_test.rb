# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class ScientificNameSearchTest < ActionController::TestCase
  tests Names::SearchController
  test "should search for scientific names" do
    get :index, q: "a*"
    assert_response :success
  end
end
