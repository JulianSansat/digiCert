require 'open-uri'
class RegularCertificatesController < ApplicationController
  before_action :set_regular_certificate, only: [:show, :edit, :update, :destroy]

  # GET /regular_certificates
  # GET /regular_certificates.json
  def index
    @regular_certificates = RegularCertificate.all
  end

  # GET /regular_certificates/1
  # GET /regular_certificates/1.json
  def show
  end

  # GET /regular_certificates/new
  def new
    @regular_certificate = RegularCertificate.new
  end

  # GET /regular_certificates/1/edit
  def edit
  end

  # POST /regular_certificates
  # POST /regular_certificates.json
  def create
    @regular_certificate = RegularCertificate.new(regular_certificate_params)
    root_cas = RootCertificate.all
    root_ca_raw = root_cas.first
    root_ca = root_ca_raw.ca
    #Paperclip.io_adapters.for(root_ca).read
    root_cert = OpenSSL::X509::Certificate.new(Paperclip.io_adapters.for(root_ca).read)
    root_key_raw = root_ca_raw.key
    root_key = OpenSSL::PKey::RSA.new(Paperclip.io_adapters.for(root_key_raw).read)
    key = OpenSSL::PKey::RSA.new 2048
    cert = OpenSSL::X509::Certificate.new
    cert.version = 2
    cert.serial = 2
    cert.subject = OpenSSL::X509::Name.parse "/DC=org/DC=#{@regular_certificate.subject}/CN=#{@regular_certificate.subject}"
    @regular_certificate.subject = cert.subject
    cert.issuer = root_cert.subject
    cert.public_key = key.public_key
    cert.not_before = Time.now
    cert.not_after = cert.not_before + 1 * 365 * 24 * 60 * 60 # 1 years validity
    ef = OpenSSL::X509::ExtensionFactory.new
    ef.subject_certificate =  root_cert
    cert.add_extension(ef.create_extension("keyUsage","digitalSignature", true))
    cert.add_extension(ef.create_extension("subjectKeyIdentifier","hash",false))
    cert.sign(root_key, OpenSSL::Digest::SHA256.new)

    ca_file = cert.to_pem
    key_file = key.to_pem
    public_key_file = key.public_key.to_pem
    @regular_certificate.ca =  StringIO.new(ca_file)
    @regular_certificate.ca_file_name = 'certificate.pem'
    @regular_certificate.key = StringIO.new(key_file)
    @regular_certificate.key_file_name = 'key.pem'
    @regular_certificate.public = StringIO.new(public_key_file)
    @regular_certificate.public_file_name = 'public_key.pem'

    respond_to do |format|
      if @regular_certificate.save
        format.html { redirect_to @regular_certificate, notice: 'Regular certificate was successfully created.' }
        format.json { render :show, status: :created, location: @regular_certificate }
      else
        format.html { render :new }
        format.json { render json: @regular_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regular_certificates/1
  # PATCH/PUT /regular_certificates/1.json
  def update
    respond_to do |format|
      if @regular_certificate.update(regular_certificate_params)
        format.html { redirect_to @regular_certificate, notice: 'Regular certificate was successfully updated.' }
        format.json { render :show, status: :ok, location: @regular_certificate }
      else
        format.html { render :edit }
        format.json { render json: @regular_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regular_certificates/1
  # DELETE /regular_certificates/1.json
  def destroy
    @regular_certificate.destroy
    respond_to do |format|
      format.html { redirect_to regular_certificates_url, notice: 'Regular certificate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular_certificate
      @regular_certificate = RegularCertificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regular_certificate_params
      params.require(:regular_certificate).permit(:subject)
    end
end
