require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file, wiki_id, file_or_build)
    file_data = File.read(file)
    wiki = Wiki::Wiki.find(wiki_id)
    case file_or_build
    when 'v'
    when 'b'
    end
  end
end