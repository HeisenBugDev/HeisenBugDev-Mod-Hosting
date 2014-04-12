class LinkWikiArticleToVersion < ActiveRecord::Migration
  def change
    add_column :wiki_articles, :version_id, :integer
    add_index :wiki_articles, :version_id
  end
end
