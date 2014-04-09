# == Schema Information
#
# Table name: wiki_articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  body        :string(255)
#  wiki_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  build_id    :integer
#  version_id  :integer
#  category_id :string(255)
#
# Indexes
#
#  index_wiki_articles_on_build_id     (build_id)
#  index_wiki_articles_on_category_id  (category_id)
#  index_wiki_articles_on_version_id   (version_id)
#  index_wiki_articles_on_wiki_id      (wiki_id)
#

require 'spec_helper'

describe Wiki::Article do
  let(:project) { FactoryGirl.create(:project) }
  let(:wiki) { FactoryGirl.create(:wiki_wiki, :project => project) }
  let(:article) { FactoryGirl.create(:wiki_article, :wiki => wiki) }

  subject { article }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:wiki) }
end
