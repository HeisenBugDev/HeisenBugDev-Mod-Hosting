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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_category, :class => 'Wiki::Category' do
    title "MyString"
    parent nil
  end
end
