# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  code_repo   :string(255)
#  subtitle    :string(255)
#

require 'spec_helper'

describe Project do
  before do
    @project = FactoryGirl.create(:project)
    @constructor_init_project = Project.new(:name => "BlockMiner1")
  end

  subject { @project }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:wiki) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:code_repo) }
  it { should validate_presence_of(:subtitle) }

  it { should ensure_length_of(:name).is_at_most(40) }
  it { should ensure_length_of(:subtitle).is_at_most(40) }

  it { should validate_uniqueness_of(:name) }

  describe "when wiki_repo is not specified" do
    it "should be defaulted" do
      expect(@constructor_init_project.wiki.repo).to(
        eq("HeisenBugDev/HeisenBugDev-content"))
    end
  end

  describe "invalid repo format" do
    before { @project.code_repo = 'hai' }
    it { should_not be_valid }
  end

  describe "valid repo format" do
    before { @project.code_repo = 'hai/hai' }
    it { should be_valid }
  end

  describe "when code_repo is not specified" do
    it "should be defaulted" do
      expect(@constructor_init_project.code_repo).to(
        eq("HeisenBugDev/BlockMiner1"))
    end
  end

  describe "when description is not specified" do
    specify { @constructor_init_project.description.should_not be_nil}
  end
end
