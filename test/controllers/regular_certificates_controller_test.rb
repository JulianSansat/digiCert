require 'test_helper'

class RegularCertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regular_certificate = regular_certificates(:one)
  end

  test "should get index" do
    get regular_certificates_url
    assert_response :success
  end

  test "should get new" do
    get new_regular_certificate_url
    assert_response :success
  end

  test "should create regular_certificate" do
    assert_difference('RegularCertificate.count') do
      post regular_certificates_url, params: { regular_certificate: { subject: @regular_certificate.subject } }
    end

    assert_redirected_to regular_certificate_url(RegularCertificate.last)
  end

  test "should show regular_certificate" do
    get regular_certificate_url(@regular_certificate)
    assert_response :success
  end

  test "should get edit" do
    get edit_regular_certificate_url(@regular_certificate)
    assert_response :success
  end

  test "should update regular_certificate" do
    patch regular_certificate_url(@regular_certificate), params: { regular_certificate: { subject: @regular_certificate.subject } }
    assert_redirected_to regular_certificate_url(@regular_certificate)
  end

  test "should destroy regular_certificate" do
    assert_difference('RegularCertificate.count', -1) do
      delete regular_certificate_url(@regular_certificate)
    end

    assert_redirected_to regular_certificates_url
  end
end
