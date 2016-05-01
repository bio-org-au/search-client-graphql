require "test_helper"

class Plants::Taxonomy::Accepted::Search::AcceptedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should search" do
    get(:index,{q: "fred"}, {})
    assert_response :success
  end
end
