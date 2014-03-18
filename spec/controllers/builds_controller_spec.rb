require 'spec_helper'

describe BuildsController do
  describe "Uploading a build" do
    describe "with an invalid project" do
      it "should say to come back later" do
        json = '{"project_name": "SwagCraft"}'
        post :create, json
        response.response_code.should eq(202)
      end
    end

    # describe "with bad build parameters" do
    #   before do
    #     Sidekiq::Testing.inline!
    #     ProjectsWorker.perform_async
    #   end
    #   describe "bad build number" do
    #     it "should give me an error" do
    #       Project.all.each { |project| puts project.name }
    #       json = '{"project_name": "QuantumCraft", "build_number": -1}'
    #       post :create, json
    #       puts response.body
    #       response.response_code.should eq(400)
    #     end
    #   end
    # end
  end
end
