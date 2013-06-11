# -*- encoding : utf-8 -*-

require 'spec_helper'

describe 'Sessions' do

  subject { page }

  before { visit root_path }

  describe 'while logged out' do
    it { should_not have_selector('*', :text => 'Logged in as') }
    it { should_not have_selector('*', :text => 'Post a Bounty') }

    it { should have_selector('*', :text => 'Sign In to Post Your Bounty') }
    it { should have_selector('.persona-login-button') }
  end

  describe 'on failed login' do

    before {
      OmniAuth.config.mock_auth[:browser_id] = :invalid_credentials
      visit '/auth/browser_id'
    }

    describe 'should display an error message on the home page' do

      it { current_path.should == root_path }
      it { should have_selector('.alert.alert-error',
          :text => 'Sign-in failed: invalid credentials') }
    end
  end

  describe 'on successful login' do

    before {
      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => 'test-user@example.com'
      })
      visit '/auth/browser_id'
    }

    describe 'should display the home page' do
      it { current_path.should == root_path }
    end

    describe 'should not display any login buttons' do
      it { should_not have_selector('.persona-login-button') }
    end

    describe 'should display the user\'s name or email' do
      it { should have_selector('.login-notify-area',
        :text => 'Logged in as test-user@example.com') }
    end

    describe 'should show the Post Bounty button on the home page' do
      it {
        should have_selector('button, input[type="button"]',
          :text => 'Post a Bounty')
      }
    end
  end
end

