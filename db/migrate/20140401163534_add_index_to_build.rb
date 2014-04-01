class AddIndexToBuild < ActiveRecord::Migration
  def change
    add_index :builds, :build_number
  end
end
