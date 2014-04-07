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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_article, :class => 'Wiki::Article' do
    title "MyString"
    body "MyString"
    wiki nil
  end
end
