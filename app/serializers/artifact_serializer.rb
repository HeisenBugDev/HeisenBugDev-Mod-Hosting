class ArtifactSerializer < ActiveModel::Serializer
  def file
    {:url => object.artifact.url}
  end

  attributes :id, :name, :file, :created_at, :updated_at,
    :downloads, :file_size

  has_one :build, :embed => :ids
end
