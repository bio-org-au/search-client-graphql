# frozen_string_literal: true
require "test_helper"

# Test the Changes Controller.
class AlwaysDetailsControllerTest < ActionController::TestCase
  test "should respond to post toggle" do
    @request.headers["Accept"] = "application/javascript"
    post "toggle"
    assert_response :success
  end
end
