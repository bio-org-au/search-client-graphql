# frozen_string_literal: true
require "test_helper"

module Taxonomy::Accepted
  # Test the Search Controller
  class SearchControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  end
end
