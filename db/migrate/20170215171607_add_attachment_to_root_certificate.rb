class AddAttachmentToRootCertificate < ActiveRecord::Migration[5.0]
  def change
    add_attachment :root_certificates, :key
    add_attachment :root_certificates, :ca
  end
end
