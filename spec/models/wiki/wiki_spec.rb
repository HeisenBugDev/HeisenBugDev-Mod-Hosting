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

require 'spec_helper'

describe Wiki::Wiki do
  subject(:wiki) { FactoryGirl.create(:wiki_wiki) }

  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:repo) }
end
