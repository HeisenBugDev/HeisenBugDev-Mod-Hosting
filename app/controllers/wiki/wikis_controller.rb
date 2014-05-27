class Wiki::WikisController < ApplicationController
  def update_wiki
    if params[:repo]
      wiki = Wiki::Wiki.find_by_repo(params[:repo])
      Wiki::RepoUpdateWorker.perform_async(wiki.id,
        params[:hard_reload]) unless wiki.nil?
    else
      Wiki::RepoUpdateWorker.perform_async(params[:id])
    end
    flash[:notice] = "Successfully queued a refresh."
    render :nothing => true
  end

  def show
    wiki = Wiki::Wiki.find(params[:id])
    project = wiki.id
    article = wiki.articles.find_by_title('home')
    article = wiki.articles.first if article.nil?
    redirect_to project_wiki_article_path(project, wiki, article)
  end
end
