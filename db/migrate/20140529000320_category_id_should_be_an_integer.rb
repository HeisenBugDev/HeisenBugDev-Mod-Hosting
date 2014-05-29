class CategoryIdShouldBeAnInteger < ActiveRecord::Migration
  def change
    execute 'ALTER TABLE wiki_articles ALTER category_id TYPE integer USING category_id::int'
    # change_column :wiki_articles, :category_id, :integer
  end
end
