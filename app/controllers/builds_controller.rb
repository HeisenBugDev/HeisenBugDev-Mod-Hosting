class BuildsController < ApplicationController
  def create
    name = params[:project_name]
    project = Project.find_by_name(name)

    if project.nil?
      ProjectsWorker.perform_async
      render :text => "Project was not found. Project database is being"\
                      "updated. Retry later"
      return
    end

    build = Build.new(params.except(:project_name))
  end
end
