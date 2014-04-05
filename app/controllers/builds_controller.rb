class BuildsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_filter :authenticate_entity_from_token!, :only => :create
  before_filter :authenticate_entity!, :only => :create

  protect_from_forgery :except => :create

  def create
    name = params[:project_name]
    if can? :manage, :all
      project = Projects.find_by_name(name)
    else
      project = current_user.projects.find_by_name(name)
    end

    if project.nil?
      ProjectsWorker.perform_async
      render :text => "Project was not found. Project database is being"\
                      " updated. Retry later", :status => :accepted
      return
    end
    build = project.builds.build(upload_params)

    if build.save
      render :text => "All is good."
    else
      render :text => build.errors.full_messages,
             :status => :bad_request
      return
    end

    upload_artifacts(build)
  end

private
  def upload_params
    params.permit(:build_number, :mod_version, :commit,
                                  :minecraft_version, :branch)
  end

  def upload_artifacts(build)
    params[:artifacts].each do |artifact|
      io = PatchedStringIO.new(Base64.decode64(artifact[:file_data]))
      io.original_filename = artifact[:file]
      artifact = build.artifacts.build(:name => artifact[:name])
      artifact.artifact = io
      artifact.save
    end
  end
end
