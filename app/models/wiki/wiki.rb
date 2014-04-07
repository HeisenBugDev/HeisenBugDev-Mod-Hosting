# == Schema Information
#
# Table name: wiki_wikis
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#  repo       :string(255)
#
# Indexes
#
#  index_wiki_wikis_on_project_id  (project_id)
#

class Wiki::Wiki < ActiveRecord::Base
  belongs_to :project
  has_many :articles

  validates_presence_of :project, on: :update
  validates_presence_of :repo
  validates_format_of :repo, :with => /(.*)\/(.*)/

  after_initialize :init

  def init
    self.repo ||= "HeisenBugDev/HeisenBugDev-content"
  end
end
