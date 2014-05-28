class DocumentationController < ApplicationController
  def index
    project = Project.find_by_name('HeisenBugDev')
    wiki = project.wiki
    article = wiki.articles.find_by_title('home')
    article ||= wiki.articles.first
    redirect_to documentation_show_path(article)
  end

  def show
    @article = Wiki::Article.find(params[:id])
    @wiki = @article.wiki
  end
end
