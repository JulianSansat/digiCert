class CreateRegularCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :regular_certificates do |t|
      t.string :subject

      t.timestamps
    end
  end
end
