# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

HeisenBugDev::Application.load_tasks

task :promote_admin => :environment do
  User.first.add_role :admin
end
