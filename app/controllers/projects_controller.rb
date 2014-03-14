class ProjectsController < ApplicationController
  def refresh_projects
    ProjectsWorker.perform_async(params[:urn])
    render :text => "Well... it didn't crash so it must be ok."
  end
end
