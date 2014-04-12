class Wiki::WikisController < ApplicationController
  def update_wiki
    if params[:repo]
      wiki = Wiki::Wiki.find_by_repo(params[:repo])
      Wiki::RepoUpdateWorker.perform_async(wiki.id,
        params[:hard_reload]) unless wiki.nil?
    else
      Wiki::RepoUpdateWorker.perform_async(params[:id], params[:hard_reload])
      redirect_to :back
    end
  end
end
