# frozen_string_literal: true

require "test_helper"

class StarsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get stars_create_url
    assert_response :success
  end

  test "should get destroy" do
    get stars_destroy_url
    assert_response :success
  end
end
