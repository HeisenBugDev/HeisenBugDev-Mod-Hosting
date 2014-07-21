class BakeDownloads < ActiveRecord::Migration
  def change
    Build.find_each(&:save)
    Project.find_each(&:save)
  end
end
