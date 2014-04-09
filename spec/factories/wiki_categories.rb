# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_category, :class => 'Wiki::Category' do
    title "MyString"
    parent nil
  end
end
