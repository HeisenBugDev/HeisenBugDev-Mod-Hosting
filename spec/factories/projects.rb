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
#  code_repo     :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "BlockMiner"
    wiki_repo "HeisenBugDev/BlockMiner-docs"
    code_repo "HeisenBugDev/BlockMiner"
    description "Mine the blocks and stuff"
  end
end
