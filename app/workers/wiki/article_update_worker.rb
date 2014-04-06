require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file, project_id)
  end
end