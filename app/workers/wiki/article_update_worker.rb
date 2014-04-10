require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file, wiki_id, stripped_file, delete=false)

    file_data = File.read(file) unless delete
    wiki = Wiki::Wiki.find(wiki_id)

    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer/home.md
    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer
    # /Users/theron/code/heisenbugdev-site/tmp/wikis/HeisenBugDev/HBD-Testing-Content/projects/blockminer/v1/ksdjf/home.md
    # "/v1/ksdjf/sdfdsf/home.md".reverse.split('/')[0].reverse #=> home.md
    base_file = stripped_file.reverse.split('/')[0].reverse
    folders = stripped_file.sub(base_file, '').sub('/','').split('/')

    title = base_file
    base_file.scan(/(\.\w*)/).each do |match|
      title.sub!(match[0], '')
    end

    return if folders[0].nil?
    sliced_folder = folders[0].dup
    sliced_folder.slice!(0)

    case folders[0]
    when /^v.*/
      version = wiki.project.versions.find_by_version(sliced_folder)

      return if version.nil?
      if delete
        wiki.articles.find_by_version_id_and_title(version.id, title).destroy
        return
      else
        article = wiki.articles.find_or_initialize_by(:version => version,
          :title => title)

        article.update_attributes(:body => file_data.to_s)
        article.save!
      end
    when /^b.*/
      build = wiki.project.builds.find_by_build_number(sliced_folder)

      return if build.nil?
      if delete

        wiki.articles.find_by_build_id_and_title(build.id, title).destroy
      else

        article = wiki.articles.find_or_initialize_by(:build => build,
          :title => title)
        article.update_attributes(:body => file_data.to_s)
        article.save!
      end
    end
  end
end