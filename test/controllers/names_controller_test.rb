# frozen_string_literal: true
require "test_helper"

# Test the Name Controller
class NamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
