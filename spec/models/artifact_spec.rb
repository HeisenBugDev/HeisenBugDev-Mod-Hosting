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

require 'spec_helper'

describe Artifact do
  let(:project) { FactoryGirl.create(:project) }
  let(:version) { FactoryGirl.create(:version, :project => project) }
  let(:build) { FactoryGirl.create(:build, :project => project,
    :version => version) }
  let(:artifact) { FactoryGirl.create(:artifact, :build => build) }

  subject { artifact }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:build) }
end
