class CreateProjectLists < ActiveRecord::Migration
  def change
    create_table :project_lists do |t|
      t.string :name
      t.timestamps
    end
  end
end
