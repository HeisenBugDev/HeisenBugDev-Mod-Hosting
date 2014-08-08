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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_category, class: 'Wiki::Category' do
    title 'MyString'
  end
end
