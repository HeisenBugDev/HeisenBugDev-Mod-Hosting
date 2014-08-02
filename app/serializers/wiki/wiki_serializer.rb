class Wiki::WikiSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  has_one :project, :embed => :ids
  has_many :categories
end
