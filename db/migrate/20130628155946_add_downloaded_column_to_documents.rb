class AddDownloadedColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :downloaded, :boolean, default: false
  end
end
