class ProjectsController < ApplicationController
  autocomplete :user, :name

  def refresh_projects
    ProjectsWorker.perform_async(params[:urn])
    render :text => "Well... it didn't crash so it must be ok."
  end

  def edit
    @project = Project.find_by_name(params[:id])
  end

end
