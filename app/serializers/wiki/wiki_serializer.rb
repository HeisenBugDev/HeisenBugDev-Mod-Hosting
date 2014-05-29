class Wiki::WikiSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :repo
  has_one :project, :embed => :ids
  has_many :articles, :embed => :ids
  has_many :categories

  def categories
    object.categories.where('parent_id IS NULL')
  end

  def articles
    object.articles.where('category_id IS NULL')
  end
end
