# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  articles_repo :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "BlockMiner"
    articles_repo "HeisenBugDev/BlockMiner"
    description "Mine the blocks and stuff"
  end
end
