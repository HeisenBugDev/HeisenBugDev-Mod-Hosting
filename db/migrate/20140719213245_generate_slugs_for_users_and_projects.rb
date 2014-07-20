class GenerateSlugsForUsersAndProjects < ActiveRecord::Migration
  def change
    User.find_each(&:save)
    Project.find_each(&:save)
  end
end
