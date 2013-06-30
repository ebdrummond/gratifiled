class AddExpiredColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :expired, :boolean, default: false
  end
end
