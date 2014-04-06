class RemoveWikiRepoFromProjectTable < ActiveRecord::Migration
  def change
    remove_column :projects, :wiki_repo
  end
end
