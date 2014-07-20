class AddOwnerSentenceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :owner_sentence, :string
  end
end
