class CreateWikiCategories < ActiveRecord::Migration
  def change
    create_table :wiki_categories do |t|
      t.string :title
      t.references :parent, index: true

      t.timestamps
    end
  end
end
