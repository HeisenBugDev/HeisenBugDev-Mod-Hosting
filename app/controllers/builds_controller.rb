class BuildsController < ApplicationController
  skip_before_filter :beta_logged_in, :only => [:create]
  acts_as_token_authentication_handler_for User
  before_filter :authenticate_entity_from_token!, :only => :create
  before_filter :authenticate_entity!, :only => :create
  include ApplicationHelper

  protect_from_forgery :except => :create

  def update
    @build = Build.find(params[:id])
    @build = nil unless can?(:update, @build)

    @build.build_state = params[:state]
    @build.save
    @project = @build.project
    flash[:notice] = 'Updated'

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @build = Build.find(params[:id])
    @build = nil unless can?(:destroy, @build)
    @project = @build.project
    if @build.nil?
      flash[:warning] = 'You do not have permission to do that!'
    elsif @build.destroy
      flash[:success] = 'Deleted build.'
    else
      flash[:error] = 'Build not deleted.'
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    name = params[:project_name]
    if can? :manage, :all
      project = Project.find_by_name(name)
    else
      project = current_user.projects.find_by_name(name)
    end

    if project.nil?
      render :text => "Project does not exist or you do not have permission!",
        :status => :not_found
      return
    end

    if params[:build_number].blank?
      latest = latest_builds(project, 1, nil)[0]
      num = latest.build_number + 1 unless latest.nil?
      num ||= 1
      params[:build_number] = num
    end

    build = project.builds.build(upload_params)
    version = Version.find_or_initialize_by(:project => project,
          :version => params[:mod_version])
    build.version = version

    if build.save
      render :text => "All is good."
    else
      render :text => build.errors.full_messages,
             :status => :bad_request
      return
    end

    upload_artifacts(build)
  end

  def download
    @project = Project.find(params[:project_id])
    file_type = params[:file_type]
    file_type ||= 'universal'
    if params[:artifact_id]
      @artifact = Artifact.find(params[:artifact_id])
      @build = @artifact.build
    elsif params[:build_id]
      @build = Build.find(params[:build_id])
      @artifact = @build.artifacts.find_by_name(file_type)
    else
      @build = latest_builds(@project, 1)[0]
      @artifact = @build.artifacts.find_by_name(file_type)
    end

    @artifact.increment!(:downloads)

    respond_to do |format|
      format.js { render :action => 'update' }
      format.all { redirect_to @artifact.artifact.url }
    end
  end

private
  def upload_params
    params.permit(:build_number, :commit, :minecraft_version, :branch)
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
