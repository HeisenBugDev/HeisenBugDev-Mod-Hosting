class BuildsController < ApplicationController
  skip_before_filter :beta_logged_in, :only => [:create]
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  before_filter :authenticate_entity_from_token!, :only => [:create, :destroy]
  before_filter :authenticate_entity!, :only => [:create, :destroy]
  include ApplicationHelper

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
      render :json => {
        :message => 'Build created.',
        :upload_path => artifact_upload_path(build)
      }
    else
      render :text => build.errors.full_messages,
             :status => :bad_request
    end
  end

  def artifact_upload
    @build = Build.find(params[:id])

    unless can? :manage, @build
      render :json => {
        :message => 'You do not have permission to do that!'
      }, :status => :unauthorized
      return
    end

    artifact = @build.artifacts.build(:name => params[:file_type])
    artifact.artifact = params[:file]

    if artifact.save
      render :json => {
        :message => 'Artifact uploaded.'
      }
    else
      render :json => {
        :message => 'Unsuccessful save. Errors are listed.',
        :errors => user.errors.full_messages
      }
    end
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
      @build = latest_stable(@project)
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
end
