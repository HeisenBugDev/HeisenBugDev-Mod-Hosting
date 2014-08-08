class Wiki::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at

  has_one :wiki, embed: :ids
  has_many :articles, embed: :ids
  has_many :subcategories
  has_one :parent_category
end
