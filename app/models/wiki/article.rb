# == Schema Information
#
# Table name: wiki_articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#
# Indexes
#
#  index_wiki_articles_on_category_id  (category_id)
#

class Wiki::Article < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title
  validates_presence_of :body
end
