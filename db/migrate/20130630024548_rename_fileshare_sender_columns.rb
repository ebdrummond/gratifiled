class RenameFileshareSenderColumns < ActiveRecord::Migration
  def change
    rename_column :fileshares, :name, :sender_name
    rename_column :fileshares, :email, :sender_email
  end
end
