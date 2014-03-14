class ProjectsController < ApplicationController
  def update
    ProjectsWorker.perform_async
    render :text => "Well... it didn't crash so it must be ok."
  end
end
