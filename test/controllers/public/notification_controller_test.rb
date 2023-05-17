require "test_helper"

class Public::NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_notification_index_url
    assert_response :success
  end
end
