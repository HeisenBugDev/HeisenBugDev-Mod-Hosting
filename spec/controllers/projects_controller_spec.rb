require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:wiki) { FactoryGirl.create(:wiki_wiki, :project => project) }

  describe 'creating a project without permissions' do
    before do
      request.env['HTTP_REFERER'] = 'where_i_came_from'
    end

    it 'should return unauthorized' do
      post :create
      response.response_code.should eq(401)
    end
  end

  describe 'creating a project with permissions' do
    before do
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
      expect {post :create, {
          :project => project_json,
          :user_token => user.authentication_token,
          :user_email => user.email
        }}.
        to change(Project, :count).by(1)
    end
  end

  describe 'Editing a project without permissions' do
    describe "update action" do
      before do
        request.env['HTTP_REFERER'] = 'where_i_came_from'
      end

      it 'should redirect to login' do
        edit_json = {
          :id => project.id,
        }

        put :update, edit_json
        response.response_code.should eq(302)
      end
    end

    describe "adding a user" do
      before do
        @other_user = FactoryGirl.create(:user, :name => 'Bill')
      end

      it 'should redirect you' do
        user_add_json = {
          :id => project.id,
          :project => {
            :users => [@other_user.name]
          },
          :user_token => user.authentication_token,
          :user_email => user.email
        }

        put :update, user_add_json
        response.response_code.should eq(302)
      end
    end
  end

  describe 'Editing a project with permissions' do
    before do
      user.projects << project
    end

    describe 'Adding a user' do
      before do
        @other_user = FactoryGirl.create(:user, :name => 'Bill')
      end

      it 'should respond with success' do
        user_add_json = {
          :user_token => user.authentication_token,
          :user_email => user.email,
          :id => project.id,
          :project => {
            :users => [@other_user.name]
          }
        }

        put :update, user_add_json
        response.should be_success
      end
    end

    describe "removing a user" do
      it "should remove the user" do
        user_remove_json = {
          :format => 'js',
          :project_id => project.id,
          :user_id => user.id,
          :user_token => user.authentication_token,
          :user_email => user.email
        }

        expect do
          post :remove_user, user_remove_json
        end.to change(project.users, :count).by(-1)
      end
    end

    describe 'Changing the code_repo' do
      it 'should change the code_repo attribute' do
        code_repo_change_json = {
          :id => project.id,
          :project => {
            :code_repo => 'hai/hai',
          },
          :user_token => user.authentication_token,
          :user_email => user.email
        }

        expect do
          patch :update, code_repo_change_json
          project.reload
        end.to change(project, :code_repo)

        response.should be_success
      end
    end
  end
end
