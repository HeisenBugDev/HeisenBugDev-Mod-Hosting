module Wiki::WikisHelper
  def get_articles
    Wiki::Article.where('category_id IS NULL')
  end

  def get_categories
    Wiki::Category.where('parent_id IS NULL')
  end
end
