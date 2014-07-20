class GenerateOwnerSentences < ActiveRecord::Migration
  def change
    Project.find_each(&:save)
  end
end
