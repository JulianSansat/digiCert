require 'test_helper'

class RootCertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @root_certificate = root_certificates(:one)
  end

  test "should get index" do
    get root_certificates_url
    assert_response :success
  end

  test "should get new" do
    get new_root_certificate_url
    assert_response :success
  end

  test "should create root_certificate" do
    assert_difference('RootCertificate.count') do
      post root_certificates_url, params: { root_certificate: {  } }
    end

    assert_redirected_to root_certificate_url(RootCertificate.last)
  end

  test "should show root_certificate" do
    get root_certificate_url(@root_certificate)
    assert_response :success
  end

  test "should get edit" do
    get edit_root_certificate_url(@root_certificate)
    assert_response :success
  end

  test "should update root_certificate" do
    patch root_certificate_url(@root_certificate), params: { root_certificate: {  } }
    assert_redirected_to root_certificate_url(@root_certificate)
  end

  test "should destroy root_certificate" do
    assert_difference('RootCertificate.count', -1) do
      delete root_certificate_url(@root_certificate)
    end

    assert_redirected_to root_certificates_url
  end
end
