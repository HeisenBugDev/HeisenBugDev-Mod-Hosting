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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_article, :class => 'Wiki::Article' do
    title "MyString"
    body "Such body. Much article."
    category nil
  end
end
