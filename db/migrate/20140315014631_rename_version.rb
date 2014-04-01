class RenameVersion < ActiveRecord::Migration
  def change
    rename_column :builds, :version, :mod_version
  end
end
