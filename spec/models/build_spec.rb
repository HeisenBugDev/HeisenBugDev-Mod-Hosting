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
#
# Indexes
#
#  index_builds_on_build_number  (build_number)
#  index_builds_on_project_id    (project_id)
#  index_builds_on_version_id    (version_id)
#

require 'spec_helper'

describe Build do
  let(:project) { FactoryGirl.create(:project) }
  let(:version) { FactoryGirl.create(:version, :project => project) }
  let(:build) { FactoryGirl.create(:build, :project => project,
    :version => version) }

  subject { build }

  it { should validate_presence_of(:build_number) }
  it { should validate_presence_of(:commit) }
  it { should validate_presence_of(:version) }
  it { should validate_presence_of(:minecraft_version) }
  it { should validate_presence_of(:branch) }
  it { should validate_presence_of(:project) }
  it { should allow_value(1, 23, 316).for(:build_number) }
  it { should_not allow_value(0, -1, -37).for(:build_number) }

  it { should validate_uniqueness_of(:build_number).scoped_to(:project_id) }
end
