class BuildSerializer < ActiveModel::Serializer
  attributes :id, :build_number, :commit, :minecraft_version, :created_at,
    :updated_at, :branch, :build_state, :downloads, :main_download

  has_one :project, :embed => :ids
  has_one :version, :embed => :ids
  has_many :artifacts, :embed => :ids, :include => true
end
