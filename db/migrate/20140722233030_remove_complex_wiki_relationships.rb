class RemoveComplexWikiRelationships < ActiveRecord::Migration
  def change
    remove_column :wiki_categories, :parent_id
    remove_column :wiki_articles, :build_id
    remove_column :wiki_articles, :version_id
    remove_column :wiki_articles, :wiki_id
    remove_column :wiki_wikis, :repo
  end
end
