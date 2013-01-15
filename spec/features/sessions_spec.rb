# encoding: UTF-8

require 'spec_helper'

describe 'Sessions' do

	subject { page }

	describe 'on failed login' do

		before {
			OmniAuth.config.mock_auth[:browser_id] = :invalid_credentials
			visit '/auth/browser_id'
		}

		describe 'should display an error message on the home page' do

			it { should have_selector('.alert.alert-error',
				  :text => 'Sign-in failed: invalid credentials') }
			it { should have_selector('.hero-unit .board-subheader',
				  :text => 'A project that connects artists to fans and fans to the artwork they love.') }
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

			it { should have_selector('.hero-unit .board-header',
				  :text => 'Welcome to the Bounty Board') }
		end

		describe 'should not display any login buttons' do
			it { should_not have_selector('.persona-login-button') }
		
		end

		describe 'should show the Post Bounty button on the home page' do

			it { should have_selector('.btn.btn-primary',
				  :text => 'Post a Bounty') }
		
		end
	end
end

