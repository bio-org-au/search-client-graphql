# frozen_string_literal: true
require "test_helper"

# Controller test
class Plants::Names::Search::Within::Taxon::AllControllerTest \
  < ActionController::TestCase
  test "should get index" do
    get :index, id: names(:angophora_costata).id
    assert_response :success
  end
end
