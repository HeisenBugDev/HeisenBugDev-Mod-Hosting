class RenameRepoAttributeInProject < ActiveRecord::Migration
  def change
    rename_column :projects, :repo, :articles_repo
  end
end
