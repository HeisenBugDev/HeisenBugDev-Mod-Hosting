# == Schema Information
#
# Table name: wiki_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  wiki_id    :integer
#

class Wiki::Category < ActiveRecord::Base
  belongs_to :wiki

  validates_presence_of :wiki

  has_many :articles, :dependent => :destroy
end
