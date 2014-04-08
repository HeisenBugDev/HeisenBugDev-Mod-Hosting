class Wiki::WikisController < ApplicationController
  def edit
    Wiki::RepoUpdateWorker.perform_async(params[:id])
  end
end
