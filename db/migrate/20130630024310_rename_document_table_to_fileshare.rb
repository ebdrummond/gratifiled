class RenameDocumentTableToFileshare < ActiveRecord::Migration
  def change
    rename_table :documents, :fileshares
  end
end
