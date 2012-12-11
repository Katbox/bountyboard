# encoding: UTF-8

require 'spec_helper'

describe 'Board' do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('.hero-unit h2',
			  :text => 'A project that connects artists to fans and fans to the artwork they love.') }
		it { should have_selector('body > header.navbar.navbar-fixed-top.navbar-inverse:first-child') }
		it { should have_selector('body > .container-fluid .row-fluid .nav-header',
			  :text => 'Sidebar') }
		it { should have_selector('body > .container-fluid:last-child footer.row-fluid') }
		it { should have_selector('body > .container-fluid:last-child footer.row-fluid',
			  :text => '© Lionheart Studio and Brent Houghton') }
	end
end

