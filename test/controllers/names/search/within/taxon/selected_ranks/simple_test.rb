# frozen_string_literal: true
require "test_helper"

# Controller test
class Names::Search::Within::Taxon::SelectedRanks::SearchControllerTest \
  < ActionController::TestCase

  test "should get index" do
    get :index, id: names(:angophora_costata).id, Species: 1
    assert_response :success
  end
end
