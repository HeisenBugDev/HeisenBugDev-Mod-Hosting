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
#  build_id   :integer
#  version_id :integer
#
# Indexes
#
#  index_wiki_articles_on_build_id    (build_id)
#  index_wiki_articles_on_version_id  (version_id)
#  index_wiki_articles_on_wiki_id     (wiki_id)
#

class Wiki::Article < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :build
  belongs_to :version

  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :wiki
end
