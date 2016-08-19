# frozen_string_literal: true
require "test_helper"

class ChangesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
