class CreateWikiArticles < ActiveRecord::Migration
  def change
    create_table :wiki_articles do |t|
      t.string :title
      t.string :body
      t.references :wiki, index: true

      t.timestamps
    end
  end
end
