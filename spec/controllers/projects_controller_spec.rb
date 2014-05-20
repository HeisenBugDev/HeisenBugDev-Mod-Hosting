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
end
