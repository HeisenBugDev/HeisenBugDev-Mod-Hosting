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

require 'spec_helper'

describe Version do
  let(:project) { FactoryGirl.create(:project) }
  let(:version) { FactoryGirl.create(:version, project: project) }

  subject { version }

  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:version) }

  it { should validate_uniqueness_of(:version).scoped_to(:project_id) }
end
