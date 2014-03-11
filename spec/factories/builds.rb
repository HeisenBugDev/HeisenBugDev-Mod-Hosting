# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  version           :string(255)
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_builds_on_project_id  (project_id)
#

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
