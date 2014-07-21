# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  created_at        :datetime
#  updated_at        :datetime
#  code_repo         :string(255)
#  subtitle          :string(255)
#  icon              :string(255)
#  slug              :string(255)
#  owner_sentence    :string(255)
#  downloads         :string(255)
#  download_sentence :string(255)
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#

require 'file_size_validator'

class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :wiki, :class_name => 'Wiki::Wiki', :dependent => :destroy
  accepts_nested_attributes_for :wiki
  mount_uploader :icon, ProjectIconUploader

  validates :icon,
    :presence => true,
    :file_size => {
      :maximum => 0.5.megabytes.to_i
    }

  has_and_belongs_to_many :users
  has_many :builds, :dependent => :destroy
  has_many :versions, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :wiki
  validates_presence_of :description
  validates_presence_of :code_repo
  validates_presence_of :subtitle

  validates_format_of :code_repo, :with => /(.*)\/(.*)/

  validates_length_of :name, :maximum => 30
  validates_length_of :subtitle, :maximum => 40

  validates_uniqueness_of :name, :case_sensitive => false

  before_save :set_owner_sentence
  before_save :set_downloads
  before_save :set_download_sentence

  after_initialize :init

  def set_download_sentence
    num = ActionController::Base.helpers.number_to_human(self.downloads)
    self.download_sentence = "#{num} Downloads"
  end

  def set_owner_sentence
    owners = (self.users.map {|user| user.name}).uniq

    if owners.size <= 2
      self.owner_sentence = owners.to_sentence
    else
      sentence = [owners[0..1], "#{owners[2..-1].size} others"].flatten.to_sentence
      self.owner_sentence = sentence
    end
  end

  def init
    self.code_repo ||= "HeisenBugDev/#{self.name}"
    self.description ||= "Such description! Much information!"
    self.wiki ||= Wiki::Wiki.new
  end

  def set_downloads
    self.downloads = self.builds.collect{|b| b.downloads }.sum
  end
end
