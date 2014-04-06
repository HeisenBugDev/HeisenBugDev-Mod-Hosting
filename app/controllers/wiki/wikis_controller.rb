class Wiki::WikisController < ApplicationController
  def index
    Wiki::RepoUpdateWorker.perform_async(1)
  end
end
