# frozen_string_literal: true
require "test_helper"

# Test the APC Controller.
class ApcControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
