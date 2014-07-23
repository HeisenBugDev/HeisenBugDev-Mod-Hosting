class AddMoreProjectDownloadAttributes < ActiveRecord::Migration
  def change
    add_column :projects, :main_download, :string
    add_column :projects, :latest_release_file, :string
    add_column :projects, :latest_beta_file, :string
    add_column :projects, :latest_normal_file, :string
  end
end
