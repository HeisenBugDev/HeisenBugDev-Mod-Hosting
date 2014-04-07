class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(project_id)
    repo = Project.find(project_id).wiki.repo
    # repo_org, repo_name = repo.split('/')
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
      @files = Dir["#{repo_tmp_dir}/**"]
    end

    @files.each do |file|
      Wiki::ArticleUpdateWorker.perform_async(file, project_id)
    end
  end
end