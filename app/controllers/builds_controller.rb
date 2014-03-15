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

    if build.save
      render :text => "All is good."
    else
      render :text => "Something went wrong. (I know, so descriptive)"
    end

    params[:artifacts].each do |artifact|
      io = PatchedStringIO.new(Base64.decode64(artifact[:file]))
      io.original_filename = artifact[:name]
      artifact = Artifact.new(:build => build)
      artifact.artifact = io
      artifact.save
    end
  end
end
