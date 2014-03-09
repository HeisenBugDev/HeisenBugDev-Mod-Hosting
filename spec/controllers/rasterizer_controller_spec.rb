require 'spec_helper'

describe RasterizerController do
  good_response = {"top" => "https://raw.github.com/HeisenBugDev/QuantumCraft/develop/src/main/resources/assets/quantumcraft/textures/blocks/machineIOF_top.png",
          "side" => "https://raw.github.com/HeisenBugDev/QuantumCraft/develop/src/main/resources/assets/quantumcraft/textures/blocks/machineIOF_side.png",
          "front" => "https://raw.github.com/HeisenBugDev/QuantumCraft/develop/src/main/resources/assets/quantumcraft/textures/blocks/machineIOF_front.png"}
  describe "When image is requested via GET" do
    it "should return a UrlGenerationError" do
      expect{get 'index'}.to raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "when image is requested via POST" do
    describe "without any parameters" do
      it "should return 400" do
        post :create
        response.response_code.should eq(400)
      end
    end

    describe "with bad parameters" do
      it "should return 400" do
        json = {'dude' => 'this should not work', 'or' => 'this'}
        post :create, json
        response.response_code.should eq(400)
      end
    end

    describe "with broken links" do
      it "should return 400" do
        json = {'top' => 'kaboom', 'side' => 'bacon', 'front' => 'broken'}
        post :create, json
        response.response_code.should eq(424)
      end
    end

    describe "with proper parameters" do
      it "should respond with success" do
        post :create, good_response
        response.should be_success
      end
    end
  end
end
