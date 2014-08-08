# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  version    :string(255)
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_versions_on_project_id  (project_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :version do
    version '0.7.1'
    project nil
  end
end
