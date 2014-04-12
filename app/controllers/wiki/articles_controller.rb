class Wiki::ArticlesController < ApplicationController
  def show
    @article = Wiki::Article.find(params[:id])
  end
end