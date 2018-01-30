# frozen_string_literal: true

require 'test_helper'

# General publication tests
class PublicationsControllerTest < ActionController::TestCase
  test 'should get suggestions' do
    get :suggestions
    assert_response :success
  end
end
