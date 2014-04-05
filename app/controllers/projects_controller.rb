class ProjectsController < ApplicationController
  autocomplete :user, :name
  acts_as_token_authentication_handler_for User
  before_filter :authenticate_entity_from_token!, :only => [:edit, :update]
  before_filter :authenticate_entity!, :only => [:edit, :update]

  def refresh_projects
    ProjectsWorker.perform_async(params[:urn])
    render :text => "Well... it didn't crash so it must be ok."
  end

  def edit
    @project = Project.find(params[:id])
    if !@project.users.include?(current_user) && !can?(:manage, :all)
      redirect_to :back, :flash => { :warning => 'You do not have permission to view that page' }
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    puts "PARAMS: #{params}"
    user = User.find_by_name(params[:project][:users])
    if user.nil?
      redirect_to :back, :flash => { :warning => 'User does not exist.' }
      return
    end
    old_size = @project.users.size
    @project.users << user unless @project.users.include?(user)
    if old_size == @project.users.size
      redirect_to :back, :flash => { :warning => 'User already existed' }
      return
    end
    redirect_to :back, :flash => { :notice => 'User added' }
    return
  end

  def remove_user
    @project = Project.find(params[:project_id])
    user = User.find(params[:user_id])
    if user
      @project.users.delete(user)
    end
    redirect_to :back, :flash => { :notice => 'User removed' }
  end
end
