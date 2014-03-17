class AddCodeRepoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :code_repo, :string
  end
end
