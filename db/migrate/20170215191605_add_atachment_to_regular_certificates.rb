class AddAtachmentToRegularCertificates < ActiveRecord::Migration[5.0]
  def change
    add_attachment :regular_certificates, :key
    add_attachment :regular_certificates, :ca
  end
end
