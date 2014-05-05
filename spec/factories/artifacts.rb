# == Schema Information
#
# Table name: artifacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  artifact   :string(255)
#  build_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  downloads  :integer
#  file_size  :string(255)
#
# Indexes
#
#  index_artifacts_on_build_id  (build_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artifact do
    name "universal"
    artifact File.open(File.join(Rails.root, 'utils/upload_data/QuantumCraft-deobf-1.7.2-0.7.1.null.jar'))
    build nil
  end
end
