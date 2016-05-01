require "test_helper"

class Plants::Taxonomy::Accepted::Search::SynonymControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
