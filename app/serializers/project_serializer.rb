class ProjectSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :description, :created_at, :updated_at, :code_repo,
    :icon, :downloads, :slug, :owner_sentence, :main_download,
    :download_sentence, :latest_release_file, :latest_beta_file, :latest_normal_file

  def latest_file(type)
    type = "" if type
    build = object.builds.order('build_number DESC').limit(1).
      where(:build_state => type).first

    artifacts = build.artifacts if build
    artifact = artifacts.find_by_name('universal').artifact.url if artifacts
  end

  ['release', 'beta', 'normal'].each do |type|
    define_method("latest_#{type}_file") do
      latest_file(type)
    end
  end

  def main_download
    build = latest_stable(object)
    artifacts = build.artifacts if build
    artifacts.find_by_name('universal').artifact.url if artifacts
  end

  has_one :wiki, :embed => :ids
  has_many :builds, :embed => :ids
  has_many :versions, :embed => :ids
end
