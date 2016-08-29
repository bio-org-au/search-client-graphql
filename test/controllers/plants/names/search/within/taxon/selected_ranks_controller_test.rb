# frozen_string_literal: true
require "test_helper"

# Controller test
module Plants
  module Names
    module Search
      module Within
        class Taxon::SelectedRanksControllerTest \
          < ActionController::TestCase
          test "should get index" do
            get :index,
                id: names(:angophora).id,
                Species: 1,
                Subspecies: 1
            assert_response :success
          end
        end
      end
    end
  end
end
