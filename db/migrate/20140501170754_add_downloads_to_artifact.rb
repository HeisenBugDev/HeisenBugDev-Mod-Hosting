class AddDownloadsToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :downloads, :integer
  end
end
