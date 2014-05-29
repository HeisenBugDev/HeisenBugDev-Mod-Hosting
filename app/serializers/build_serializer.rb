class BuildSerializer < ActiveModel::Serializer
  attributes :id, :build_number, :commit, :minecraft_version, :created_at,
    :updated_at, :branch, :build_state
  has_one :project, :embed => :ids
  has_one :version, :embed => :ids
end
