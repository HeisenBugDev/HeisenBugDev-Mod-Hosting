require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:wiki) { FactoryGirl.create(:wiki_wiki, project: project) }
  let(:version) { FactoryGirl.create(:version, project: project) }

  describe "Requesting a project" do
    before do
      @b = FactoryGirl.create(:build, project: project, version: version)
      @b2 = FactoryGirl.create(:build, project: project, build_number: 10,
                                 version: version, build_state: :release)
      project.reload
    end

    it "should respond with" do
      get :show, id: project.id, format: :json
      response.should be_success
      body = JSON.parse(response.body)
      body.should include('builds')
      body.should include('versions')
      body["builds"].should have(2).items
      body["versions"].should have(1).items
      body["artifacts"].should have(0).items

      body["project"]["build_ids"].should have(2).items
    end
  end

  pending "Updating"
  pending "Destroying"
  pending "Show"
  pending "Downloads"
  pending "Owners"
end
