class ArtifactSerializer < ActiveModel::Serializer
  def file
    {:url => object.artifact.url}
  end

  attributes :id, :name, :file, :build_id, :created_at, :updated_at,
    :downloads, :file_size
end
