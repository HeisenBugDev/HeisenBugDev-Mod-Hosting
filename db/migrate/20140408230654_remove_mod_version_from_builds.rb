class RemoveModVersionFromBuilds < ActiveRecord::Migration
  def change
    remove_columns :builds, :mod_version
  end
end
