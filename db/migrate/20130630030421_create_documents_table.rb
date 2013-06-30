class CreateDocumentsTable < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :fileshare
      t.string     :document_file_name
      t.string     :document_content_type
      t.integer    :document_file_size
      t.datetime   :document_updated_at
      t.boolean    :downloaded, default: false
      t.boolean    :expired, default: false

      t.timestamps
    end
    add_index :documents, :fileshare_id
  end
end
