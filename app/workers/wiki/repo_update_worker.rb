class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(project_id)
    repo = Project.find(project_id).wiki_repo
    # repo_org, repo_name = repo.split('/')
    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    repo_tmp_dir = File.join(tmp_dir, repo)

    if File.directory?(repo_tmp_dir)
      Dir.chdir(repo_tmp_dir) do
        @old_commit = `git rev-parse HEAD`
        `git pull`
        @new_commit = `git rev-parse HEAD`
      end
    else
      FileUtils.mkpath(tmp_dir)
      Dir.chdir(tmp_dir) do
        `git clone https://github.com/#{repo}.git #{repo}`
      end
    end

    Dir.chdir(repo_tmp_dir) do
      commits = "#{@old_commit} #{@new_commit}"
      puts @changed_files = `git diff --name-only #{commits}`.split("\n")
    end

    @changed_files.map! do |file|
      File.absolute_path(File.join(repo_tmp_dir, file))
    end

    @changed_files.each do |file|
      Wiki::ArticleUpdatWorker.perform_async(file, project_id)
    end
  end
end