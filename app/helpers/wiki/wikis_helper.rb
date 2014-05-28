module Wiki::WikisHelper
  def get_articles(wiki)
    Wiki::Article.where('category_id IS NULL AND wiki_id = ?', wiki.id)
  end

  def get_categories(wiki)
    Wiki::Category.where('parent_id IS NULL AND wiki_id = ?', wiki.id)
  end
end
