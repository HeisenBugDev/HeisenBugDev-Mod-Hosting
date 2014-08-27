class RemoveStupidIdLimits < ActiveRecord::Migration
  def change
    change_column :projects, :latest_release_build_id, :integer, limit: nil
    change_column :projects, :latest_beta_build_id, :integer, limit: nil
    change_column :projects, :latest_normal_build_id, :integer, limit: nil
  end
end
