class AddIndexToBuilds < ActiveRecord::Migration
  def change
    add_index :builds, :version_id
  end
end
