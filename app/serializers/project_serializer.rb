class ProjectSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :subtitle, :icon, :downloads, :slug, :owner_sentence, :main_download

  def main_download
    latest_stable(object).artifacts.find_by_name('universal').artifact.url
  end

  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
