# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  repo        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Project do
  before do
    @project = Project.new(
      :name           => "BlockMiner",
      :repo           => "HeisenBugDev/BlockMiner",
      :description    => "Mine the blocks and stuff."
    )
  end

  subject { @project }

  describe "when name is not present" do
    before { @project.name = nil }
    it { should_not be_valid }
  end

  describe "when repo is not present" do
    before { @project.repo = nil }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @project.description = nil}
    it { should_not be_valid }
  end
end
