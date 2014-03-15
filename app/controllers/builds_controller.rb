class BuildsController < ApplicationController
  protect_from_forgery :except => :create

  def create
    name = params[:project_name]
    project = Project.find_by_name(name)

    if project.nil?
      ProjectsWorker.perform_async
      render :text => "Project was not found. Project database is being"\
                      "updated. Retry later"
      return
    end
    build = project.builds.build(upload_params)

    if build.save!
      render :text => "All is good."
    else
      render :text => "Something went wrong. (I know, so descriptive)", :status => :bad_request
    end

    params[:artifacts].each do |artifact|
      io = PatchedStringIO.new(Base64.decode64(artifact[:file_data]))
      io.original_filename = artifact[:file]
      artifact = build.artifacts.build(:name => artifact[:name])
      artifact.artifact = io
      artifact.save
    end
  end

private
  def upload_params
    params.require(:build).permit(:build_number, :mod_version, :commit, :minecraft_version, :branch)
  end
end
