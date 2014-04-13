class AddSubtitleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :subtitle, :string
  end
end
