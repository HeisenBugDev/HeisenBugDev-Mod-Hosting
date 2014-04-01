class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :build_number
      t.string :version
      t.string :commit
      t.string :minecraft_version
      t.references :project, index: true

      t.timestamps
    end
  end
end
