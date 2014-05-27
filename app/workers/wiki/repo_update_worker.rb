require 'fileutils'

class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(wiki_id)
    wiki = Wiki::Wiki.find(wiki_id)
    repo = wiki.repo

    @wikis = []
    Wiki::Wiki.where('repo = ?', repo).each do |a_wiki|
      @wikis << a_wiki
    end

    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    repo_tmp_dir = File.join(tmp_dir, repo)

    FileUtils.rm_rf(repo_tmp_dir)
    FileUtils.mkpath(tmp_dir)
    Dir.chdir(tmp_dir) do
      `git clone https://github.com/#{repo}.git #{repo}`
    end

    @files = Dir["#{repo_tmp_dir}/**/*"]

    @wikis.each do |a_wiki|
      start = File.join(repo_tmp_dir, 'projects')
      start_full = File.join(start, a_wiki.project.name)

      @files.each do |file|
        if file.start_with?(start_full) && File.file?(file)
          file.sub!(start_full, '')

          wiki_attrs = a_wiki.repo.split('/')
          base_file = file.reverse.split('/')[0].reverse
          folders = file.sub(base_file, '').sub('/','').split('/')

          if !folders[0].nil? && folders[0].match(/^(v|b).*/)
            category_folders = folders.drop(1)
          else
            category_folders = folders
          end

          file_params = {
            :wiki_id => wiki.id,
            :prefix => start,
            :repo_owner => wiki_attrs[0],
            :repo_name => wiki_attrs[1],
            :mod_name => a_wiki.project.name,
            :categories => category_folders,
            :file => base_file
          }

          case folders[0]
          when /^v.*/
            file_params[:version] = folders[0][1..-1]
          when /^b.*/
            file_params[:build] = folders[0][1..-1]
          end

          Wiki::ArticleUpdateWorker.perform_async(file_params)
        end
      end
    end
  end
end
