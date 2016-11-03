require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get four_oh_four" do
    get errors_four_oh_four_url
    assert_response :success
  end

  test "should get five_hundred" do
    get errors_five_hundred_url
    assert_response :success
  end

end
