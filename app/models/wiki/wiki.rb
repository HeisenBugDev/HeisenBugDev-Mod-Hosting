# == Schema Information
#
# Table name: wiki_wikis
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_wiki_wikis_on_project_id  (project_id)
#

class Wiki::Wiki < ActiveRecord::Base
  belongs_to :project
  has_many :categories, dependent: :destroy

  validates_presence_of :project, on: :update
end
