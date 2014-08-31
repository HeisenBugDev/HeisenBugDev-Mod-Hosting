# == Schema Information
#
# Table name: projects
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :text
#  created_at              :datetime
#  updated_at              :datetime
#  code_repo               :string(255)
#  icon                    :string(255)
#  slug                    :string(255)
#  owner_sentence          :string(255)
#  downloads               :integer
#  download_sentence       :string(255)
#  main_download           :string(255)
#  latest_release_build_id :integer
#  latest_beta_build_id    :integer
#  latest_normal_build_id  :integer
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#

require 'spec_helper'

describe Project do
  before do
    @project = FactoryGirl.create(:project)
    @constructor_init_project = Project.new(name: 'BlockMiner1')
  end

  subject { @project }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:wiki) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:code_repo) }

  it { should ensure_length_of(:name).is_at_most(30) }

  it { should validate_uniqueness_of(:name) }

  describe 'invalid repo format' do
    before { @project.code_repo = 'hai' }
    it { should_not be_valid }
  end

  describe 'valid repo format' do
    before { @project.code_repo = 'hai/hai' }
    it { should be_valid }
  end

  describe 'when code_repo is not specified' do
    it 'should be defaulted' do
      expect(@constructor_init_project.code_repo).to(
        eq('HeisenBugDev/BlockMiner1'))
    end
  end

  describe 'when description is not specified' do
    specify { @constructor_init_project.description.should_not be_nil }
  end

  describe "latest_builds" do
    before do
      version = @project.versions.create(version: '1.1.1')

      build_number = 0
      15.times do |number|
        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'master')

        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'develop', build_state: :beta)

        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'master', build_state: :beta)

        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'master', build_state: :release)

        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'master', build_state: :normal)

        @project.builds.create(version: version, build_number: build_number += 1,
          minecraft_version: '1.8', commit: 'omgsomething', branch: 'master', build_state: :bugged)
      end
    end

    describe "giving me latest" do
      it "should give me latest" do
        @project.latest_builds.map(&:build_state).should_not be_nil
        @project.latest_builds.size.should eq(5)
      end
    end

    describe "giving me latest of a custom state" do
      it "should give me latest of a custom state" do
        @project.latest_builds(:normal).map(&:build_state).uniq.
          should match_array(['normal'])
      end
    end

    describe "giving me latest of aliased states" do
      it "should give me latest of an aliased state" do
        @project.latest_builds(:stable).map(&:build_state).uniq.
          should match_array(['beta', 'release'])
      end
    end

    describe "allow me to configure the limit" do
      it "should allow me to configure the limit" do
        @project.latest_builds(limit: 10).size.should eq(10)
      end
    end

    describe "allow me to pass extra where params" do
      it "should allow me to pass extra where params" do
        @project.latest_builds(extra_where_params: {commit: 'omgsomething'}).
          map(&:commit).uniq.should match_array(['omgsomething'])
      end
    end

    describe "allow me to configure the branch" do
      it "should allow me to configure the branch" do
        @project.latest_builds(branch: 'develop').map(&:branch).uniq.
          should match_array(['develop'])
      end
    end
  end

  describe "main builds" do
    before do
      version = @project.versions.create(version: '1.1.1')

      build_number = 0
      @build_release = @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsometfhing', branch: 'master', build_state: 'release')

      @build_beta = @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsomethsing', branch: 'master', build_state: 'beta')

      @build_normal = @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsomethiang', branch: 'master', build_state: 'normal')

      @project.reload
    end

    # it "should set main builds" do
    #   @project.latest_release_build.should eq(@build_release)
    #   @project.latest_beta_build.should    eq(@build_beta)
    #   @project.latest_normal_build.should  eq(@build_normal)
    # end
  end

  describe "giving me branches" do
    before do
      version = @project.versions.create(version: '1.1.1')

      build_number = 0
      @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsomething', branch: 'master')

      @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsomething', branch: 'develop')

      @project.builds.create(version: version, build_number: build_number += 1,
        minecraft_version: '1.8', commit: 'omgsomething', branch: 'master')
    end

    it "should give me branches" do
      @project.branches.should match_array(['master', 'develop'])
    end
  end
end
