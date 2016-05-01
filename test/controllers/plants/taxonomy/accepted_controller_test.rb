require "test_helper"

class Plants::Taxonomy::AcceptedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
