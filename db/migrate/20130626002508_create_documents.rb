class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :email
      t.string :recipient_email
      t.text   :message

      t.timestamps
    end
  end
end
