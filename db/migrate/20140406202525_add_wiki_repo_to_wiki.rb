class AddWikiRepoToWiki < ActiveRecord::Migration
  def change
    add_column :wiki_wikis, :wiki_repo, :string
  end
end
