require "test_helper"

class Plants::Names::Search::CultivarControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
