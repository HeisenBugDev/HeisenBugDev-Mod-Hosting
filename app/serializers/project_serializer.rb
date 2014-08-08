class ProjectSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
             :icon, :downloads, :slug, :owner_sentence, :download_sentence,
             :main_download

  has_one :latest_release_build, embed: :ids
  has_one :latest_beta_build, embed: :ids
  has_one :latest_normal_build, embed: :ids

  has_one :wiki, embed: :ids
  has_many :builds, embed: :ids
  has_many :versions, embed: :ids
end
