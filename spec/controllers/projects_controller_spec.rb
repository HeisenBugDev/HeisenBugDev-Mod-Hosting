require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:wiki) { FactoryGirl.create(:wiki_wiki, project: project) }

  pending "Updating"
  pending "Destroying"
  pending "Index should not exist"
  pending "Show"
  pending "Downloads"
  pending "Owners"
end
