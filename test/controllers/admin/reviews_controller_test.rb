# frozen_string_literal: true

require "test_helper"

class Admin::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_reviews_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_reviews_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_reviews_update_url
    assert_response :success
  end
end
