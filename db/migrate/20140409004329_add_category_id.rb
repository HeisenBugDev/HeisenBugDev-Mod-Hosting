class AddCategoryId < ActiveRecord::Migration
  def change
    add_column :wiki_articles, :category_id, :string
    add_index :wiki_articles, :category_id
  end
end
