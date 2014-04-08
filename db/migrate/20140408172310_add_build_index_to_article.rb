class AddBuildIndexToArticle < ActiveRecord::Migration
  def change
    add_column :wiki_articles, :build_id, :integer
    add_index :wiki_articles, :build_id
  end
end
