class ProjectSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :icon, :downloads, :slug, :owner_sentence, :latest_release_file,
    :latest_beta_file, :latest_normal_file, :download_sentence, :main_download

  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
