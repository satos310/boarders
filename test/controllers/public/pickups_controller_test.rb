# frozen_string_literal: true

require "test_helper"

class Public::PickupsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_pickups_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_pickups_destroy_url
    assert_response :success
  end
end
