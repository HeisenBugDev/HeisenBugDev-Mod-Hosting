class RenameArticleRepoAttribute < ActiveRecord::Migration
  def change
    rename_column :projects, :articles_repo, :wiki_repo
  end
end
