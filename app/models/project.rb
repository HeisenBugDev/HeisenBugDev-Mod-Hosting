# == Schema Information
#
# Table name: projects
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :text
#  created_at              :datetime
#  updated_at              :datetime
#  code_repo               :string(255)
#  icon                    :string(255)
#  slug                    :string(255)
#  owner_sentence          :string(255)
#  downloads               :integer
#  download_sentence       :string(255)
#  main_download           :string(255)
#  latest_release_build_id :integer
#  latest_beta_build_id    :integer
#  latest_normal_build_id  :integer
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#

require 'file_size_validator'

class Project < ActiveRecord::Base
  include ApplicationHelper

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :wiki, class_name: 'Wiki::Wiki', dependent: :destroy
  accepts_nested_attributes_for :wiki
  mount_uploader :icon, ProjectIconUploader

  belongs_to :latest_release_build, class_name: 'Build'
  belongs_to :latest_beta_build, class_name: 'Build'
  belongs_to :latest_normal_build, class_name: 'Build'

  validates :icon,
    :presence => true,
            file_size: {
              maximum: 0.5.megabytes.to_i
            }

  has_and_belongs_to_many :users
  has_many :builds, -> { order "build_number DESC" }, dependent: :destroy
  has_many :versions, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :wiki
  validates_presence_of :description
  validates_presence_of :code_repo

  validates_format_of :code_repo, with: /(.*)\/(.*)/

  validates_length_of :name, maximum: 30

  validates_uniqueness_of :name, case_sensitive: false

  after_save :set_owner_sentence
  after_save :set_downloads
  after_save :set_download_sentence
  after_save :set_main_builds

  after_initialize :init

  #
  # Get the latest builds for a project.
  # @param state [Symbol] Build state. :stable, :beta, :bugged, etc.
  #   Not providing it or nil will ignore the build_state.
  # @param branch: [String] git branch name. If nil, the results will not be
  #   filtered by branch.
  # @param limit: [Integer] Max amount of builds to return.
  # @param extra_where_params: Extra params to be added to the where search.
  #
  # @return [Array<Build>] Array of builds.
  def latest_builds(state=nil, branch: 'master', limit: 5, extra_where_params: {})
    hashes = Build::STATES.find { |state| state.is_a? Hash }
    state_lookup = (hashes[state] if hashes.include?(state)) ||
      (state if Build::STATES.include?(state))

    (branch_lookup = branch ? { branch: branch} : {}).
      merge!(extra_where_params)

    branch_lookup.merge!({build_state: state_lookup}) if state_lookup

    self.builds.where(branch_lookup).first(limit)
  end

  def branches
    Build.uniq.where(project: self).pluck(:branch)
  end

  def set_main_builds
    self.latest_release_build = builds.order('build_number DESC').limit(1).
      where(build_state: 'release').first

    self.latest_beta_build = builds.order('build_number DESC').limit(1).
      where(build_state: 'beta').first

    self.latest_normal_build = builds.order('build_number DESC').limit(1).
      where(build_state: 'normal').first

    self.main_download = ''
    build = self.latest_builds(:stable)[0]
    artifacts = build.artifacts if build
    artifact = artifacts.find_by_name('universal') if artifacts
    url = artifact.artifact.url if artifact
    self.main_download = url
  end

  def set_download_sentence
    return unless self.respond_to?(:download_sentence)
    num = ActionController::Base.helpers.number_to_human(downloads)
    self.download_sentence = "#{num} Downloads"
  end

  def set_owner_sentence
    return unless self.respond_to?(:owner_sentence)
    owners = (users.map { |user| user.name }).uniq

    if owners.size <= 2
      self.owner_sentence = owners.to_sentence
    else
      sentence = [owners[0..1], "#{owners[2..-1].size} others"].flatten.to_sentence
      self.owner_sentence = sentence
    end
  end

  def init
    self.code_repo ||= "HeisenBugDev/#{name}"
    self.description ||= 'Such description! Much information!'
    self.wiki ||= Wiki::Wiki.new
  end

  def set_downloads
    return unless self.respond_to?(:downloads)
    self.downloads = builds.map { |b| b.downloads }.sum
  end
end
