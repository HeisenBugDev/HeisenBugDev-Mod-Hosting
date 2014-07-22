class DeleteSubtitleFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :subtitle
  end
end
