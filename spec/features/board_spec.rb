# encoding: UTF-8

require 'spec_helper'

describe 'Bounty' do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('.hero-unit .board-subheader',
			  :text => 'Artists for hire. Will draw for food.') }
		it { should have_selector('body .navbar') }
		it { should have_selector('body .navbar-inner') }
		it { should have_selector('footer.row-fluid',
			  :text => '© Lionheart Studio and Brent Houghton') }
	end
end

