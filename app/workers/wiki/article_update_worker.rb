require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file, wiki_id, version_or_build)
    file_data = File.read(file)
    wiki = Wiki::Wiki.find(wiki_id)

    case version_or_build
    when /^v/
      version_or_build.slice!(0)
      # wiki.project.versions.find_by_version(version_or_build).articles
      #   .find_or_initialize_by()
    when /^b/
      version_or_build.slice!(0)
    end
  end
end