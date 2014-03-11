# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  repo        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  has_many :builds, :dependent => :destroy

  validates :name, :presence => true
  validates :repo, :presence => true
  validates :description, :presence => true
end
