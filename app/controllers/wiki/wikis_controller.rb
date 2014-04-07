class Wiki::WikisController < ApplicationController
  def index
    Wiki::RepoUpdateWorker.perform_async(Project.first.id)
  end
end
