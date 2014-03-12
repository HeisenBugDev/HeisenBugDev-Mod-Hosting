class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :name
      t.string :download_file
      t.references :build, index: true

      t.timestamps
    end
  end
end
