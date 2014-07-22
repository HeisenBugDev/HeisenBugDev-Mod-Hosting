class ProjectSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :icon, :downloads, :slug, :owner_sentence, :main_download,
    :download_sentence

  def main_download
    build = latest_stable(object)
    artifacts = build.artifacts if build
    artifacts.find_by_name('universal').artifact.url if artifacts
  end

  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
