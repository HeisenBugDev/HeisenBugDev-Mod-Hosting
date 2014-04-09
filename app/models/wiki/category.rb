# == Schema Information
#
# Table name: wiki_categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_wiki_categories_on_parent_id  (parent_id)
#

class Wiki::Category < ActiveRecord::Base
  has_many :subcategories, :class_name => "Category",
    :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category"

  has_many :articles, :dependent => :destroy
end
