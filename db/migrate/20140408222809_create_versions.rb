class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version
      t.references :project, index: true

      t.timestamps
    end
  end
end
