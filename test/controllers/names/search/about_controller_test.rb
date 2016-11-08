# frozen_string_literal: true
require "test_helper"

# Test the Name Search Controller.
class Names::Search::AboutControllerTest < ActionController::TestCase
  test "should get index" do
    @request.headers["Accept"] = "application/javascript"
    xhr :get, :index
    assert_response :success
  end
end
