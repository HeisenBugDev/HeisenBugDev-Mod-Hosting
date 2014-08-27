class AddDownloadSentenceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :download_sentence, :string
  end
end
