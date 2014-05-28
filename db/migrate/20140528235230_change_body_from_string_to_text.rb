class ChangeBodyFromStringToText < ActiveRecord::Migration
  def change
    change_column :wiki_articles, :body, :text
  end
end
