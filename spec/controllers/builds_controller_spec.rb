require 'spec_helper'

describe BuildsController do
  json = { :project_name => 'QuantumCraft',
           :build_number => 13,
           :minecraft_version => '1.9',
           :mod_version => '0.8.3',
           :branch => 'develop',
           :commit => '23wyedfjkk' }

  describe "Uploading a build" do
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
          name_only_json = { :project_name => 'QuantumCraft' }
          post :create, name_only_json
          response.response_code.should eq(400)
        end
      end

      describe "bad build number" do
        it "should give me an error" do
          request_json = replace_hash_value(json, {:build_number => -1})
          post :create, request_json
          response.response_code.should eq(400)
        end
      end
    end

    after do
      Sidekiq::Testing.fake!
    end
  end
end
