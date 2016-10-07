# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class SimpleSearchTest < ActionController::TestCase
  tests Names::SearchController
  test "should search" do
    get :index, q: "angophora*"
    assert_response :success
  end
end
