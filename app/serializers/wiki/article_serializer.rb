class Wiki::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  has_one :wiki, :embed => :ids
  has_one :build, :embed => :ids
  has_one :version, :embed => :ids
  has_one :category, :embed => :ids
end
