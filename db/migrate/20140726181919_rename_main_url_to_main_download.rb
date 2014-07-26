class RenameMainUrlToMainDownload < ActiveRecord::Migration
  def change
    rename_column :builds, :main_url, :main_download
  end
end
