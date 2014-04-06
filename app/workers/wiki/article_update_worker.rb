require 'rugged'
require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform
    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    if File.directory?(tmp_dir)

    else
      FileUtils.mkpath(tmp_dir)
      Rugged::Repository.clone_at('https://github.com/HeisenBugDev/HeisenBugDev-content.git', tmp_dir)
    end
  end
end