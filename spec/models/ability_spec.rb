require 'cancan/matchers'
require 'spec_helper'

describe 'User' do
  describe 'abilities' do
    let(:user) { FactoryGirl.create(:user) }
    subject(:ability) { Ability.new(user) }

    describe 'when is an admin' do
      before { user.add_role 'admin' }
      it { should be_able_to(:manage, :all) }
    end

    describe 'when not an admin' do
      it { should_not be_able_to(:manage, :all) }
      it { should be_able_to(:read, :all) }
      describe 'when user has a project' do
        let(:project) { FactoryGirl.create(:project) }
        before do
          project.users << user
        end
        it { should be_able_to(:edit, project) }
      end
    end
  end
end
