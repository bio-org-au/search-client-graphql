# frozen_string_literal: true
require "test_helper"

# Test the Plants Name Search Controller.
class NamesShowSimpleTest < ActionController::TestCase
  tests NamesController
  test "should show" do
    name = names(:angophora_costata)
    get :show, id: name.id
    assert_response :success
  end
end
