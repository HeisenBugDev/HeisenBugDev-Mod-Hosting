class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(wiki_id)
    wiki = Wiki::Wiki.find(wiki_id)
    repo = wiki.repo
    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    repo_tmp_dir = File.join(tmp_dir, repo)

    if File.directory?(repo_tmp_dir)
      Dir.chdir(repo_tmp_dir) do
        @old_commit = `git rev-parse HEAD`
        `git pull`
        @new_commit = `git rev-parse HEAD`
        commits = "#{@old_commit} #{@new_commit}"
        @files = `git diff --name-only #{commits}`.split("\n")
      end
    else
      FileUtils.mkpath(tmp_dir)
      Dir.chdir(tmp_dir) do
        `git clone https://github.com/#{repo}.git #{repo}`
      end
      @files = Dir["#{repo_tmp_dir}/**/*"]
    end

    start = File.join(repo_tmp_dir, 'projects', wiki.project.name)

    @files.each do |file|
      if file.start_with?(start) && File.file?(file)
        Wiki::ArticleUpdateWorker.perform_async(file, wiki_id)
      end
    end
  end
end