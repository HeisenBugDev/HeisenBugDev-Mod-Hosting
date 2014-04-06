begin
  ActiveRecord::Migration.check_pending!
rescue Exception
  stop = true
end

unless stop
  ProjectsWorker.perform_async
end