# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :build do
    build_number 1
    version "MyString"
    commit "MyString"
    minecraft_version "MyString"
    project nil
  end
end
