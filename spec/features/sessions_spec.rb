# encoding: UTF-8

require 'spec_helper'

describe 'Sessions' do

  subject { page }

  describe 'hidden Persona form should not be visible' do
    it { should_not have_selector('#browser-id-form') }
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
  end
end

