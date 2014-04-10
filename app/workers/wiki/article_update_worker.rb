require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file, wiki_id, stripped_file)

    file_data = File.read(file)
    wiki = Wiki::Wiki.find(wiki_id)

    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer/home.md
    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer
    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer/v1/ksdjf/home.md
    # "/v1/ksdjf/sdfdsf/home.md".reverse.split('/')[0].reverse #=> home.md
    base_file = stripped_file.reverse.split('/')[0].reverse
    folders = stripped_file.sub(base_file, '').sub('/','').split('/')

    case folders[0]
    when /^v.*/
      folders[0].slice!(0)
      version = wiki.project.versions.find_by_version(folders[0])
      return if version.nil?

      article = Wiki::Article.find_or_initialize_by(:wiki => wiki,
        :version => version)
      title = base_file
      base_file.scan(/(\.\w*)/).each do |match|
        title.sub!(match[0], '')
      end
      article.update_attributes(:title => title, :body => file_data.to_s)
      article.save!
    when /^b.*/
      folders[0].slice!(0)
    end
  end
end