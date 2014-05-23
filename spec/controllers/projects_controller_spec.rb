require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  describe 'creating a project without permissions' do
    before do
      sign_in user
      request.env['HTTP_REFERER'] = 'where_i_came_from'
    end

    it 'should return unauthorized' do
      post :create
      response.response_code.should eq(401)
    end
  end

  describe 'creating a project with permissions' do
    before do
      sign_in user
      user.add_role 'admin'
    end

    project = FactoryGirl.build(:project)
    project_json = JSON.parse(project.to_json)
    project_json[:wiki_attributes] = { :repo => 'HeisenBugDev/HBD-Content' }
    project_json[:icon] = Rack::Test::UploadedFile.new(File.join(
      Rails.root,
      'spec',
      'factories',
      'files',
      'crystal_quantonium.png'
    ))

    it 'should create a project' do
      expect {post :create, {:project => project_json}}.
        to change(Project, :count).by(1)
    end
  end

  describe 'Editing a project without permissions' do
    before do
      sign_in user
      request.env['HTTP_REFERER'] = 'where_i_came_from'
    end

    it 'should return unauthorized' do
      edit_json = {
        :id => project.id
      }

      post :update, edit_json
      response.response_code.should eq(401)
    end
  end

  describe 'Editing a project with permissions' do
    before do
      user.projects << project
      sign_in user
    end

    describe 'Adding a user' do
      before do
        @other_user = FactoryGirl.create(:user, :name => 'Bill')
      end

      it 'should respond with success' do
        user_add_json = {
          :id => project.id,
          :project => {
            :users => [@other_user.name]
          }
        }

        post :update, user_add_json
        response.should be_success
      end
    end
  end
end
