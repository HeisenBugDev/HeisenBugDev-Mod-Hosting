class RemoveBodyLimit < ActiveRecord::Migration
  def change
    change_column :wiki_articles, :body, :text, :limit => nil
  end
end
