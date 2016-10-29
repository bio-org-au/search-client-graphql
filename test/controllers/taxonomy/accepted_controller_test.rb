# frozen_string_literal: true
require "test_helper"

# Test Accepted Taxonomy Controller
class Taxonomy::AcceptedControllerTest < ActionController::TestCase
  test "should get index" do
    skip
    assert_throws AbstractController::ActionNotFound do
      get :index
    end
  end
end
