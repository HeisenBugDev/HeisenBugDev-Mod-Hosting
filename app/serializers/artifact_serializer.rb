class ArtifactSerializer < ActiveModel::Serializer
  def file_url
    object.artifact.url
  end

  attributes :id, :name, :file_url, :created_at, :updated_at,
             :downloads, :file_size

  has_one :build, embed: :ids
end
