class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(wiki_id, hard_reload)
    wiki = Wiki::Wiki.find(wiki_id)
    repo = wiki.repo

    @wikis = []
    Wiki::Wiki.where('repo = ?', repo).each do |a_wiki|
      @wikis << a_wiki
    end

    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    repo_tmp_dir = File.join(tmp_dir, repo)

    if File.directory?(repo_tmp_dir)
      Dir.chdir(repo_tmp_dir) do
        @old_commit = `git rev-parse HEAD`
        `git pull`
        @new_commit = `git rev-parse HEAD`
        commits = "#{@old_commit.delete("\n")} #{@new_commit.delete("\n")}"
        @files = `git diff --name-only --diff-filter=AM #{commits}`.split("\n")
        @renamed_files = `git diff --name-only --diff-filter=R #{commits}`
        .split("\n")
        del_file_command = "git diff --diff-filter=D --name-only #{commits}"
        @deleted_files = `#{del_file_command}`.split("\n")

        [@files, @deleted_files].each do |array|
          array.map! do |file|
            File.absolute_path(file)
          end
        end
      end
    else
      FileUtils.mkpath(tmp_dir)
      Dir.chdir(tmp_dir) do
        `git clone https://github.com/#{repo}.git #{repo}`
      end
      @files = Dir["#{repo_tmp_dir}/**/*"]
    end

    if hard_reload
      @files = Dir["#{repo_tmp_dir}/**/*"]
    end

    @wikis.each do |a_wiki|
      start = File.join(repo_tmp_dir, 'projects', a_wiki.project.name)

      @files.each do |file|
        if file.start_with?(start) && File.file?(file)
          folder_search = file.sub(start, '')
        # Stuff like v12.3.0 or b233
        Wiki::ArticleUpdateWorker.perform_async(file, a_wiki.id, folder_search)
      end
    end

    unless @deleted_files.nil?
      @deleted_files.each do |file|
        if file.start_with?(start)
          folder_search = file.sub(start, '')
          Wiki::ArticleUpdateWorker.perform_async(file, a_wiki.id,
            folder_search, true)
        end
      end
    end
  end
end
end