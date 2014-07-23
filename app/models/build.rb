# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  branch            :string(255)
#  version_id        :integer
#  build_state       :string(255)
#  downloads         :string(255)
#
# Indexes
#
#  index_builds_on_build_number  (build_number)
#  index_builds_on_project_id    (project_id)
#  index_builds_on_version_id    (version_id)
#

class Build < ActiveRecord::Base
  after_initialize :init

  resourcify
  belongs_to :project
  belongs_to :version

  has_many :artifacts, :dependent => :destroy

  validates_presence_of :build_number
  validates_presence_of :commit
  validates_presence_of :minecraft_version
  validates_presence_of :branch
  validates_presence_of :project
  validates_presence_of :version

  before_save :set_downloads
  after_save :save_parent

  validates_numericality_of :build_number, :only_integer => true,
                                           :greater_than => 0,
                                           :message => "Build number must be"\
                                           "greater than 0"

  validates_uniqueness_of :build_number, :scope => :project_id

  def init
    self.build_state ||= 'normal'
  end

  def set_downloads
    self.downloads = self.artifacts.sum('downloads')
  end

  def save_parent
    self.project.save
  end
end
