# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  mod_version       :string(255)
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  branch            :string(255)
#
# Indexes
#
#  index_builds_on_build_number  (build_number)
#  index_builds_on_project_id    (project_id)
#

class Build < ActiveRecord::Base
  resourcify
  belongs_to :project
  has_many :artifacts, :dependent => :destroy

  validates_presence_of :build_number
  validates_presence_of :mod_version
  validates_presence_of :commit
  validates_presence_of :minecraft_version
  validates_presence_of :branch
  validates_presence_of :project

  validates_numericality_of :build_number, :only_integer => true,
                                           :greater_than => 0,
                                           :message => "Build number must"\
                                           "greater than 0"

  validates_uniqueness_of :build_number, :scope => :project_id
end
