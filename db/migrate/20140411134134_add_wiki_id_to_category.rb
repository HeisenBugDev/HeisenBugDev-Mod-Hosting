class AddWikiIdToCategory < ActiveRecord::Migration
  def change
    add_column :wiki_categories, :wiki_id, :integer
  end
end
