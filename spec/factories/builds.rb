# == Schema Information
#
# Table name: builds
#
#  id                :integer          not null, primary key
#  build_number      :integer
#  commit            :string(255)
#  minecraft_version :string(255)
#  project_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  branch            :string(255)
#  version_id        :integer
#  build_state       :string(255)
#  downloads         :string(255)
#
# Indexes
#
#  index_builds_on_build_number  (build_number)
#  index_builds_on_project_id    (project_id)
#  index_builds_on_version_id    (version_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :build do
    build_number 1
    commit "ce6d688"
    branch "1337-this-better-be-awesome"
    minecraft_version "1.7.2"
  end
end
