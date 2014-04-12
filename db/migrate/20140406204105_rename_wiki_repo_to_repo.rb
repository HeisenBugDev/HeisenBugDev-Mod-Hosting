class RenameWikiRepoToRepo < ActiveRecord::Migration
  def change
    rename_column :wiki_wikis, :wiki_repo, :repo
  end
end
