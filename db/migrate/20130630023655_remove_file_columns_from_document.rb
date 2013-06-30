class RemoveFileColumnsFromDocument < ActiveRecord::Migration
  def change
    remove_column :documents, :document_file_name
    remove_column :documents, :document_content_type
    remove_column :documents, :document_file_size
    remove_column :documents, :document_updated_at
    remove_column :documents, :downloaded
    remove_column :documents, :expired
  end
end
