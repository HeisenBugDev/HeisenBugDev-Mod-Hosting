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

require 'spec_helper'

describe Wiki::Article do
  let(:project) { FactoryGirl.create(:project) }
  let(:wiki) { FactoryGirl.create(:wiki_wiki, :project => project) }
  let(:category) { FactoryGirl.create(:wiki_category, :wiki => wiki) }
  let(:article) { FactoryGirl.create(:wiki_article, :category => category) }

  subject { article }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
