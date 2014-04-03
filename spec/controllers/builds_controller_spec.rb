require 'spec_helper'

describe BuildsController do
  json = { :project_name => 'BlockMiner',
           :build_number => 13,
           :minecraft_version => '1.9',
           :mod_version => '0.8.3',
           :branch => 'develop',
           :commit => '23wyedfjkk' }

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
    user.projects << FactoryGirl.create(:project)
  end

  describe "logged out" do
    it "should not accept it" do
      sign_out user
      post :create, json
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "Uploading a build" do
    describe "with a project I don't have" do
      it "should say come back later" do
        FactoryGirl.create(:project, :name => 'BlockMiner123')
        bad_json = json.dup
        replace_hash_value(bad_json, {:project_name => 'BlockMiner123'})
        puts bad_json
        post :create, bad_json
        response.response_code.should eq(202)
      end
    end
    describe "with an invalid project" do
      it "should say to come back later" do
        bad_name = { :project_name => "SwagCraft" }
        post :create, bad_name
        response.response_code.should eq(202)
      end
    end

    describe "with bad build parameters" do
      before do
        Sidekiq::Testing.inline!
        ProjectsWorker.perform_async
      end

      describe "missing parameters" do
        it "give me a missing parameters error" do
          name_only_json = { :project_name => 'BlockMiner' }
          post :create, name_only_json
          response.response_code.should eq(400)
        end
      end

      describe "bad build number" do
        it "should give me an error" do
          request_json = json.dup
          replace_hash_value(request_json, {:build_number => -1})
          post :create, request_json
          response.response_code.should eq(400)
        end
      end

      after do
        Sidekiq::Testing.fake!
      end
    end

    describe "with good build parameters" do
      it "should upload the file" do
        good_json = json.dup
        good_json[:artifacts] = [{
          :name => 'universal',
          :file => 'universal.jar',
          :file_data => 'ZGF0YWlzY29vbA=='
        }]
        expect{ post :create, good_json }.to change(Artifact, :count).by(1)
      end
    end
  end
end
