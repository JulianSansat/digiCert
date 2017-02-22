class AddPublicKeyAttachmentToCerts < ActiveRecord::Migration[5.0]
  def change
    add_attachment :regular_certificates, :public
  end
end
