# frozen_string_literal: true
require "test_helper"

# Test the Taxonomy Accepted Search About Controller.
class Taxonomy::Accepted::Search::AboutControllerTest  \
  < ActionController::TestCase
  test "should get index" do
    @request.headers["Accept"] = "application/javascript"
    xhr :get, :index
    assert_response :success
  end
end
