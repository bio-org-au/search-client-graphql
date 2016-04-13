require "test_helper"

class SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get apni" do
    get :apni
    assert_response :success
  end

  test "should get apc" do
    get :apc
    assert_response :success
  end

end
