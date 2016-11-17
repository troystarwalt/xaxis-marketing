# frozen_string_literal: true
require 'test_helper'

class LandingPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get value_calculator" do
    get landing_pages_value_calculator_url
    assert_response :success
  end

  test "should get expert_interview_hub" do
    get landing_pages_expert_interview_hub_url
    assert_response :success
  end

end
