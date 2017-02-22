require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_index_url
    assert_response :success
  end

  test "should get cert_verification" do
    get main_cert_verification_url
    assert_response :success
  end

  test "should get show_cert_verification" do
    get main_show_cert_verification_url
    assert_response :success
  end

end
