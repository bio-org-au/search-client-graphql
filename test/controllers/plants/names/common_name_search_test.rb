# frozen_string_literal: true
require "test_helper"

# Test the Plants Name Search Controller.
class Plants::Names::CommonNameSearchTest < ActionController::TestCase
  tests SearchController
  test "should search for common names" do
    get :index, q: "a*", search_type: "common"
    assert_response :success
  end
end
