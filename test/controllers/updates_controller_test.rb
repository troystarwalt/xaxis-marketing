require 'test_helper'

class UpdatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get updates_index_url
    assert_response :success
  end

  test "should get new" do
    get updates_new_url
    assert_response :success
  end

  test "should get create" do
    get updates_create_url
    assert_response :success
  end

  test "should get destroy" do
    get updates_destroy_url
    assert_response :success
  end

  test "should get main" do
    get updates_main_url
    assert_response :success
  end

end
