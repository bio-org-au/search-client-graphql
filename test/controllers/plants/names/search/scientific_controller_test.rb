require "test_helper"

class Plants::Names::Search::ScientificControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
