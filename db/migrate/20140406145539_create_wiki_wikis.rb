class CreateWikiWikis < ActiveRecord::Migration
  def change
    create_table :wiki_wikis do |t|
      t.references :project, index: true

      t.timestamps
    end
  end
end
