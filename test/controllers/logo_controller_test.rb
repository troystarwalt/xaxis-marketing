require 'test_helper'

class LogosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get logo_new_url
    assert_response :success
  end

  test "should get create" do
    get logo_create_url
    assert_response :success
  end

  test "should get delete" do
    get logo_delete_url
    assert_response :success
  end

end
