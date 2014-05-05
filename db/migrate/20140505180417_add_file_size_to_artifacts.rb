class AddFileSizeToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :file_size, :string
  end
end
