require 'spec_helper'

describe ProjectsController do
  describe "when projects are told to be refreshed" do
    it "should change the job queue by 1" do
      expect { get :refresh_projects }.to change(ProjectsWorker.jobs, :size).by(1)
    end

    it "should increase the Project count by 1" do
      Project.delete_all
      Project.delete_all
      Project.delete_all
      expect { ProjectsWorker.drain }.to change(Project, :count).by(1)
    end
  end

  describe "when the projects file has new data and there is a refresh" do
    before do
      get :refresh_projects
      ProjectsWorker.drain
    end

    it "should change the description" do
      urn = '/HeisenBugDev/HeisenBugDev-content/master/projects_data_change_test_env.json'
      get :refresh_projects, :urn => urn
      expect { ProjectsWorker.drain }.to change{ Project.find_by_name('QuantumCraft').description }.to('Yet another tech mod')
    end

  end
end
