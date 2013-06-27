class AddUuidToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :uuid, :string
  end
end
