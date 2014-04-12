module Wiki::WikisHelper
  def get_articles
    Wiki::Article.where('category_id IS NULL')
  end

  def get_categoriesaaa
    categories = []
    get_parent_categories.each do |category|
      categories << category
      unless category.subcategories.nil?
        categories << get_subcategories(category)
      end
    end
    categories
  end

  def get_subcategories(parent_category)
    categories = []
    parent_category.subcategories.each do |sub_category|
      categories << sub_category
      unless sub_category.subcategories.nil?
        categories << get_subcategories(sub_category)
      end
    end

    if categories.blank?
      nil
    else
      categories
    end
  end

  def get_categories
    Wiki::Category.where('parent_id IS NULL')
  end
end
