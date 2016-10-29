# frozen_string_literal: true
require "test_helper"

# Test the Config Controller.
class ConfigControllerTest < ActionController::TestCase
  test "should respond to get" do
    get :index
    assert_response :success
  end
end
