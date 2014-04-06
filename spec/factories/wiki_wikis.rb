# == Schema Information
#
# Table name: wiki_wikis
#
#  id         :integer          not null, primary key
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#  repo       :string(255)
#
# Indexes
#
#  index_wiki_wikis_on_project_id  (project_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki_wiki, :class => 'Wiki::Wiki' do
    project FactoryGirl.create(:project)
  end
end
