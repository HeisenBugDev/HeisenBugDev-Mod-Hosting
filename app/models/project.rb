# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  code_repo   :string(255)
#  subtitle    :string(255)
#  icon        :string(255)
#

class Project < ActiveRecord::Base
  has_one :wiki, :class_name => 'Wiki::Wiki', :dependent => :destroy
  accepts_nested_attributes_for :wiki
  mount_uploader :icon, ProjectIconUploader

  has_and_belongs_to_many :users
  has_many :builds, :dependent => :destroy
  has_many :versions, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :wiki
  validates_presence_of :description
  validates_presence_of :code_repo
  validates_presence_of :subtitle

  validates_format_of :code_repo, :with => /(.*)\/(.*)/

  validates_length_of :name, :maximum => 40
  validates_length_of :subtitle, :maximum => 40

  validates_uniqueness_of :name, :case_sensitive => false

  after_initialize :init

  def init
    self.code_repo ||= "HeisenBugDev/#{self.name}"
    self.description ||= "Such description! Much information!"
    self.wiki ||= Wiki::Wiki.new
  end
end
