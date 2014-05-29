class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :subtitle, :icon
end
