# frozen_string_literal: true
require "test_helper"

# Test the Search Controller
class TaxonomyOtherSimpleTest < ActionController::TestCase
  tests Taxonomy::OtherController
  test "should get index" do
    get :index
    assert_response :success, "Should get index."
  end
end
