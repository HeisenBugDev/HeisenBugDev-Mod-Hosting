# require_relative '../workers/wiki/article_'

class Wiki::WikisController < ApplicationController
  def index
    Wiki::ArticleUpdateWorker.perform_async
  end
end
