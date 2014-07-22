class ProjectsController < ApplicationController
  autocomplete :user, :name
  acts_as_token_authentication_handler_for User
  before_filter :authenticate_entity_from_token!, :only => [:edit, :update]
  before_filter :authenticate_entity!, :only => [:edit, :update]

  def edit
    @project = Project.find(params[:id])
    if !@project.users.include?(current_user) && !can?(:manage, :all)
      redirect_to :back, :flash => { :warning => 'You do not have permission to view that page' }
    end
  end

  def show
    @project = Project.friendly.find(params[:id])
    # @users = @project.users
    render :json => @project
  end

  def index
    @projects = Project.paginate(page: params[:page])
    render :json => @projects
  end

  def new
    unless can? :manage, :all
      redirect_to :back, :flash =>
        { :warning => 'You do not have permission to view that page' }
      return
    end

    @project = Project.new
    @project.build_wiki
  end

  def create
    unless can? :manage, :all
      redirect_to :back, :flash =>
        { :warning => 'You do not have permission to view that page' },
          :status  => :unauthorized
      return
    end

    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])
    unless can? :edit, @project
      redirect_to :back, :status => :unauthorized
      return
    end

    user = User.find_by_name(params[:project][:users])
    unless user.nil?
      old_size = @project.users.size
      @project.users << user unless @project.users.include?(user)
      if old_size == @project.users.size
        flash[:warning] = 'User already added'
      else
        flash[:success] = 'User added'
      end
      @users = @project.users
      respond_to do |format|
        format.js
        format.all { render :text => 'It worked!' }
      end
      return
    end
    @users = @project.users
    respond_to do |format|
      old_icon = Digest::SHA1.hexdigest(@project.icon.read)

      if @project.update_attributes(project_params)
        @new_image = (old_icon != Digest::SHA1.hexdigest(@project.icon.read.to_s))
        format.json { respond_with_bip(@project) }
        format.js
        format.all { render :text => 'Updated' }
      else
        format.json { respond_with_bip(@project) }
        format.js
        format.all { render :action => "edit" }
      end
    end
  end

  def remove_user
    @project = Project.find(params[:project_id])
    user = User.find(params[:user_id])
    if user
      @project.users.delete(user)
    end
    flash[:success] = 'User removed'
    @users = @project.users
    render :json => { :message => 'success' }
  end

  def downloads
    @project = Project.find(params[:project_id])
    @branch = params[:branch]

    respond_to do |format|
      format.js
    end
  end

private
  def project_params
    params.require(:project).permit(
      :name,
      :description,
      :icon,
      :code_repo,
      :wiki_attributes => [:repo]
    )
  end
end
