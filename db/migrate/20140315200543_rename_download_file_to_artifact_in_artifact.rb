class RenameDownloadFileToArtifactInArtifact < ActiveRecord::Migration
  def change
    rename_column :artifacts, :download_file, :artifact
  end
end
