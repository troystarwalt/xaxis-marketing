require 'test_helper'

class PresentationHubControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get presentation_hub_index_url
    assert_response :success
  end

end
