class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :subtitle, :icon, :downloads, :slug, :owner_sentence

  # def main_download
  #   build = object.builds.
  #   artifact = object.artifacts.find_by_name('universal')
  #   return if artifact.nil?
  #   artifact.artifact.url
  # end

  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
