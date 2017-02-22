include ActionView::Helpers::OutputSafetyHelper
class RootCertificatesController < ApplicationController
  before_action :set_root_certificate, only: [:show, :edit, :update, :destroy]

  # GET /root_certificates
  # GET /root_certificates.json
  def index
    @root_certificates = RootCertificate.all
  end

  # GET /root_certificates/1
  # GET /root_certificates/1.json
  def show
  end

  # GET /root_certificates/new
  def new
    @root_certificate = RootCertificate.new
  end

  # GET /root_certificates/1/edit
  def edit
  end

  # POST /root_certificates
  # POST /root_certificates.json
  def create
    @root_certificate = RootCertificate.new(root_certificate_params)
    root_key = OpenSSL::PKey::RSA.new 2048 # the CA's public/private key
    root_ca = OpenSSL::X509::Certificate.new
    root_ca.version = 2
    root_ca.serial = 1
    root_ca.subject = OpenSSL::X509::Name.parse "/DC=org/DC=Julian/CN=Julian CA"
    root_ca.issuer = root_ca.subject # root CA's are "self-signed"
    root_ca.public_key = root_key.public_key
    root_ca.not_before = Time.now
    root_ca.not_after = root_ca.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity
    ef = OpenSSL::X509::ExtensionFactory.new
    ef.subject_certificate = root_ca
    ef.issuer_certificate = root_ca
    root_ca.add_extension(ef.create_extension("basicConstraints","CA:TRUE",true))
    root_ca.add_extension(ef.create_extension("keyUsage","keyCertSign, cRLSign", true))
    root_ca.add_extension(ef.create_extension("subjectKeyIdentifier","hash",false))
    root_ca.add_extension(ef.create_extension("authorityKeyIdentifier","keyid:always",false))
    root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)


    ca_file = root_ca.to_pem
    key_file = root_key.to_pem
    @root_certificate.ca =  StringIO.new(ca_file)
    @root_certificate.ca_file_name = 'root_certificate.pem'
    @root_certificate.key = StringIO.new(key_file)
    @root_certificate.key_file_name = 'root_key.pem'


    respond_to do |format|
      if @root_certificate.save
        format.html { redirect_to @root_certificate, notice: 'Root certificate was successfully created.' }
        format.json { render :show, status: :created, location: @root_certificate }
      else
        format.html { render :new }
        format.json { render json: @root_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /root_certificates/1
  # PATCH/PUT /root_certificates/1.json
  def update
    respond_to do |format|
      if @root_certificate.update(root_certificate_params)
        format.html { redirect_to @root_certificate, notice: 'Root certificate was successfully updated.' }
        format.json { render :show, status: :ok, location: @root_certificate }
      else
        format.html { render :edit }
        format.json { render json: @root_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /root_certificates/1
  # DELETE /root_certificates/1.json
  def destroy
    @root_certificate.destroy
    respond_to do |format|
      format.html { redirect_to root_certificates_url, notice: 'Root certificate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_root_certificate
      @root_certificate = RootCertificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def root_certificate_params
      params.fetch(:root_certificate, {}).permit(:ca, :key)
    end
end
