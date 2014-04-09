# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  version    :string(255)
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_versions_on_project_id  (project_id)
#

class Version < ActiveRecord::Base
  belongs_to :project
  has_many :builds, :dependent => :destroy
  has_many :articles, :dependent => :destroy

  validates_presence_of :project
  validates_presence_of :version

  validates_uniqueness_of :version, :scope => :project_id
end
