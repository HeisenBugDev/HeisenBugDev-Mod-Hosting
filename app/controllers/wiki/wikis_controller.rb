class Wiki::WikisController < ApplicationController
  def update_wiki
    puts "in #update_wiki"
    Wiki::RepoUpdateWorker.perform_async(params[:id])
    puts "repo update worker has been queued"
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
