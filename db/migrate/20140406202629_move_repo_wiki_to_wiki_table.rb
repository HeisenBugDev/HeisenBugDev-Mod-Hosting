class MoveRepoWikiToWikiTable < ActiveRecord::Migration
  def change
    Project.find_each do |project|
      project.create_wiki(
        project_id: project.id,
        wiki_repo: project.wiki_repo
      )
    end
  end
end
