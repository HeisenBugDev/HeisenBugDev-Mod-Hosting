# == Schema Information
#
# Table name: artifacts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  download_file :string(255)
#  build_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_artifacts_on_build_id  (build_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artifact do
    name "Universal"
    download_file "PointMeToTheUrl"
    build nil
  end
end
