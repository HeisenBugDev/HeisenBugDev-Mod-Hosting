class BuildSerializer < ActiveModel::Serializer
  attributes :id, :build_number, :commit, :minecraft_version, :created_at,
    :updated_at, :branch, :build_state, :downloads, :main_download

  def main_download
    artifact = object.artifacts.find_by_name('universal')
    return if artifact.nil?
    artifact.artifact.url
  end

  has_one :project, :embed => :ids
  has_one :version, :embed => :ids
  has_many :artifacts, :embed => :ids, :include => true
  has_many :articles, :embed => :ids
end
