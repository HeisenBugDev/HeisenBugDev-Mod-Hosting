class ResetArticles < ActiveRecord::Migration
  def change
    change_column :wiki_articles, :category_id, :integer, :limit => nil
  end
end
