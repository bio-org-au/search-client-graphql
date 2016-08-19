# frozen_string_literal: true
require "test_helper"

class Plants::Taxonomy::Accepted::SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
