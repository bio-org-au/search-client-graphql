# frozen_string_literal: true
require "test_helper"

# Test the Citations Controller.
class CitationsControllerTest < ActionController::TestCase
  test "should respond to post toggle" do
    post :toggle
    assert_response :success
  end
end
