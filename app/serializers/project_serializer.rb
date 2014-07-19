class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :subtitle, :icon, :downloads
  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
