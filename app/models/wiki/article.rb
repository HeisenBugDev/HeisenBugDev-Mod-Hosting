# == Schema Information
#
# Table name: wiki_articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :string(255)
#  wiki_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_wiki_articles_on_wiki_id  (wiki_id)
#

class Wiki::Article < ActiveRecord::Base
  belongs_to :wiki

  validates_presence_of :title
  validates_presence_of :body
end
