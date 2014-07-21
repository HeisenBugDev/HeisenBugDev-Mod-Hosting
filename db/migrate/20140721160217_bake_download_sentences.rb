class BakeDownloadSentences < ActiveRecord::Migration
  def change
    Project.find_each(&:save)
  end
end
