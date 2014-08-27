class AddBakedDownloads < ActiveRecord::Migration
  def change
    add_column :projects, :downloads, :string
    add_column :builds, :downloads, :string
  end
end
