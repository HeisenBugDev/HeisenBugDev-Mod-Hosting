# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  version           :string(255)
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_builds_on_project_id  (project_id)
#

class Build < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :build_number
  validates_presence_of :version
  validates_presence_of :commit
  validates_presence_of :minecraft_version
end
