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

require 'spec_helper'

describe Project do
  before do
    @project = FactoryGirl.create(:project)
    @constructor_init_project = Project.new(:name => "BlockMiner1")
  end

  subject { @project }

  describe "when name is not present" do
    before { @project.name = nil }
    it { should_not be_valid }
  end

  describe "when articles_repo is not present" do
    before { @project.articles_repo = nil }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @project.description = nil}
    it { should_not be_valid }
  end

  describe "when articles_repo is not specified" do
    it "should be defaulted" do
      expect(@constructor_init_project.articles_repo).to eq("HeisenBugDev/BlockMiner1")
    end
  end

  describe "when description is not specified" do
    specify { @constructor_init_project.description.should_not be_nil}
  end
end