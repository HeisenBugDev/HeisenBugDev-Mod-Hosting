# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  articles_repo :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  code_repo     :string(255)
#

class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :builds, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :wiki_repo
  validates_presence_of :description
  validates_presence_of :code_repo

  validates_uniqueness_of :name

  after_initialize :init

  def init
    self.code_repo ||= "HeisenBugDev/#{self.name}"
    self.description ||= "Such description! Much information!"
    self.wiki_repo ||= "HeisenBugDev/HeisenBugDev-content"
  end
end
