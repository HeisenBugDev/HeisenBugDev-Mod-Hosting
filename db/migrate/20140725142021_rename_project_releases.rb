class RenameProjectReleases < ActiveRecord::Migration
  def change
    rename_column :projects, :latest_release_file, :latest_release_build_id
    rename_column :projects, :latest_beta_file, :latest_beta_build_id
    rename_column :projects, :latest_normal_file, :latest_normal_build_id
  end
end
