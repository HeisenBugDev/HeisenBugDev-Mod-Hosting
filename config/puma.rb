on_worker_boot do
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
end