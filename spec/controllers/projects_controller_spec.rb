require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }

  describe "creating a project without permissions" do
    before do
      sign_in user
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "should return unauthorized" do
      post :create
      response.response_code.should eq(401)
    end
  end

  describe "creating a project with permissions" do
    before do
      sign_in user
      user.add_role 'admin'
    end

    project = FactoryGirl.build(:project)
    project_json = JSON.parse(project.to_json)
    project_json[:wiki_attributes] = {:repo => 'HeisenBugDev/HBD-Content'}
    project_json[:icon] = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec',
      'factories', 'files', 'crystal_quantonium.png'))

    it "should create a project" do
      expect {post :create, {:project => project_json}}.
        to change(Project, :count).by(1)
    end
  end
end
