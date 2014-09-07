class RemoveLatestColumns < ActiveRecord::Migration
  def change
    remove_column :projects, :latest_release_build_id
    remove_column :projects, :latest_beta_build_id
    remove_column :projects, :latest_normal_build_id
  end
end
