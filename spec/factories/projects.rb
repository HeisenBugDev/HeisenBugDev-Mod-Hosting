# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  code_repo      :string(255)
#  subtitle       :string(255)
#  icon           :string(255)
#  slug           :string(255)
#  owner_sentence :string(255)
#  downloads      :string(255)
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :project do
    name "BlockMiner"
    code_repo "HeisenBugDev/BlockMiner"
    description "Mine the blocks and stuff"
    subtitle "Something short and tasty"

    # Warning: icon will be a string, not a file!
    icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec',
      'factories', 'files', 'crystal_quantonium.png')) }
  end
end
