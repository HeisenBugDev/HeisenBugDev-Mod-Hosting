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

  validates_presence_of :project
  validates_presence_of :version
end
