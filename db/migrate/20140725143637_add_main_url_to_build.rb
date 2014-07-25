class AddMainUrlToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :main_url, :string
  end
end
