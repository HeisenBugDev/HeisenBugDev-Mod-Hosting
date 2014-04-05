class ProjectsController < ApplicationController
  autocomplete :user, :name

  def refresh_projects
    ProjectsWorker.perform_async(params[:urn])
    render :text => "Well... it didn't crash so it must be ok."
  end

  def edit
    @project = Project.find_by_name(params[:id])
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

    end
    redirect_to :back, :flash => { :notice => 'User added' }
    return
  end

end
