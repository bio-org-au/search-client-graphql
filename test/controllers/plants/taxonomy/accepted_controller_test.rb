# frozen_string_literal: true
require "test_helper"

# Test Plants Accepted Taxonomy Controller
class Plants::Taxonomy::AcceptedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
