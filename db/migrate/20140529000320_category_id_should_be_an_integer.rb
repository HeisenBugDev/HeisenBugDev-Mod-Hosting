class CategoryIdShouldBeAnInteger < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.adapter_name == "PostgreSQL"
      execute 'ALTER TABLE wiki_articles ALTER category_id TYPE integer USING category_id::int'
    else
      change_column :wiki_articles, :category_id, :integer
    end
  end
end
