# frozen_string_literal: true
require "test_helper"

# controller test
class ImageCacheControllerTest < ActionController::TestCase
  test "should post update" do
    Names::Services::Images.expects(:load)
                           .returns(nil)
    xhr :post, :update, as: :json
    assert_response :success
    assert_equal "text/javascript", @response.content_type
  end
end
