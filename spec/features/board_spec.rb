# encoding: UTF-8

require 'spec_helper'

describe 'Board' do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('.hero-unit .board-subheader',
			  :text => 'A project that connects artists to fans and fans to the artwork they love.') }
		it { should have_selector('body .navbar') }
		it { should have_selector('body .navbar-inner') }
		it { should have_selector('footer.row-fluid',
			  :text => '© Lionheart Studio and Brent Houghton') }
	end
end

