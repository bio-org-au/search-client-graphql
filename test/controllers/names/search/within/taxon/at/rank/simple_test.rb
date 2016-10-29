# frozen_string_literal: true
require "test_helper"

# Controller test
class Names::Search::Within::Taxon::At::RankControllerTest \
  < ActionController::TestCase

  test "should get index" do
    @request.headers["Accept"] = "application/javascript"
    xhr(:get, :index,
        { id: names(:angophora_costata).id,
          rank: "species" },
        {},
        xhr: true)
    assert_response :success
  end
end
