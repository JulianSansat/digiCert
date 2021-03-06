require 'open-uri'
class MainController < ApplicationController
  def root_get
    @root_cas = RootCertificate.all
    @root_ca_raw = @root_cas.first
    @root_ca = @root_ca_raw.ca
    #Paperclip.io_adapters.for(root_ca).read
    @root_cert = OpenSSL::X509::Certificate.new(Paperclip.io_adapters.for(@root_ca).read)
    @root_key_raw = @root_ca_raw.key
    @root_key = OpenSSL::PKey::RSA.new(Paperclip.io_adapters.for(@root_key_raw).read)
  end

  def index
  end

  def cert_verification
  end

  def show_cert_verification
    root_get
    cert = OpenSSL::X509::Certificate.new(params[:file].read)
    @subject = cert.subject.to_s
    @regular_certificate = RegularCertificate.find_by(subject: @subject)

    if @regular_certificate != nil
        @check_certificate = OpenSSL::X509::Certificate.new(Paperclip.io_adapters.for(@regular_certificate.ca).read)
        @result = @check_certificate.verify(@root_cert.public_key)
        if @result == true
        @issuer = cert.issuer
        @subject = cert.subject
        end
    end
  end

  def sign_document

  end

  def document_signed
        root_get
        data = params[:file].read
        digest = OpenSSL::Digest::SHA256.new
        pkey = @root_key
        signature = pkey.sign(digest, data)
        debugger
  end

end




