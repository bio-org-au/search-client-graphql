# frozen_string_literal: true
require "test_helper"

# Controller test
module Names
  module Search
    module Within
      # Controller test
      class Taxon::SummaryControllerTest < ActionController::TestCase
        test "should get index" do
          get :index, id: names(:angophora_costata).id
          assert_response :success
        end
      end
    end
  end
end
