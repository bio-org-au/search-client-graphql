# frozen_string_literal: true
require "test_helper"

# Controller test
class Names::Search::Within::Taxon::At::RankControllerTest \
  < ActionController::TestCase
  test "should get index" do
    get :index, id: names(:angophora_costata).id, rank: "species"
    assert_response :success
  end
end
