class Wiki::WikisController < ApplicationController
  def edit
    Wiki::RepoUpdateWorker.perform_async(params[:id], params[:hard_reload])
    redirect_to :back
  end
end
