require 'spec_helper'

describe BuildsController do
  json = {
    :project_name => 'BlockMiner',
    :build_number => 13,
    :minecraft_version => '1.9',
    :mod_version => '0.8.3',
    :branch => 'develop',
    :commit => '23wyedfjkk'
  }

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.projects << FactoryGirl.create(:project)
  end

  describe "logged out" do
    it "should not accept it" do
      request.accept = 'application/json'
      post :create, json
      response.response_code.should eq(401)
    end
  end

  describe "Uploading a build" do
    describe "with a project I don't have" do
      it "should say come back later" do
        FactoryGirl.create(:project, :name => 'BlockMiner123')
        bad_json = json.dup
        bad_json[:user_token] = user.authentication_token
        bad_json[:user_email] = user.email
        replace_hash_value(bad_json, {:project_name => 'BlockMiner123'})
        post :create, bad_json
        response.response_code.should eq(404)
      end
    end

    describe "with an invalid project" do
      it "should say to come back later" do
        bad_name = { :project_name => "SwagCraft" }
        bad_name[:user_token] = user.authentication_token
        bad_name[:user_email] = user.email
        post :create, bad_name
        response.response_code.should eq(404)
      end
    end

    describe "with bad build parameters" do
      describe "missing parameters" do
        it "give me a missing parameters error" do
          name_only_json = { :project_name => 'BlockMiner' }
          name_only_json[:user_token] = user.authentication_token
          name_only_json[:user_email] = user.email
          post :create, name_only_json
          response.response_code.should eq(400)
        end
      end

      describe "bad build number" do
        it "should give me an error" do
          request_json = json.dup
          request_json[:user_token] = user.authentication_token
          request_json[:user_email] = user.email
          replace_hash_value(request_json, {:build_number => -1})
          post :create, request_json
          response.response_code.should eq(400)
        end
      end
    end

    describe "with good build parameters" do
      let(:project) { FactoryGirl.create(:project, :name => 'BaconCraft') }
      let(:version) { FactoryGirl.create(:version, :project => project) }

      let(:build) do
        FactoryGirl.create(:build, :project => project, :version => version)
      end

      before do
        project.users << user
      end

      it "should send me the upload info" do
        create_build_response = {
          :message => 'Build created.',
          :upload_path => "/api/builds/#{build.id + 1}"
        }.to_json

        jsonb = json.dup
        jsonb[:user_token] = user.authentication_token
        jsonb[:user_email] = user.email

        post :create, jsonb

        response.body.should match(create_build_response)
      end

      it "should upload the artifact" do
        upload_json = {
          :id => build.id,
          :file_type => 'universal',
          :file => Rack::Test::UploadedFile.new(File.join(
            Rails.root,
            'spec',
            'factories',
            'files',
            'universal.jar'
          ))
        }

        upload_json[:user_token] = user.authentication_token
        upload_json[:user_email] = user.email

        expect { post :artifact_upload, upload_json }.
          to change(Artifact, :count).by(1)
      end
    end
  end
end
