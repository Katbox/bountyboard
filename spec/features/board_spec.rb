# encoding: UTF-8

require 'spec_helper'

describe 'Board' do

	describe "Home page" do

		it 'should map the root URL to the board#index action' do
			visit '/'
			root_page = page.source
			visit '/board/index'
			board_index_page = page.source
			root_page.should == board_index_page
		end

		it 'the Board view should be rendered in the application layout\'s .hero-unit div' do
			visit '/board/index'
			page.should have_selector('.hero-unit h1',
			  :text => 'Welcome to the Bounty Board')
			page.should have_selector('.hero-unit h2',
			  :text => 'A project that connects artists to fans and fans to the artwork they love.')
		end

		it 'the nav bar should be rendered at the top of the page' do
			visit '/board/index'
			page.should have_selector('body > header.navbar.navbar-fixed-top.navbar-inverse:first-child')
		end

		it 'the sidebar should be rendered in the correct place' do
			visit '/board/index'
			page.should have_selector('body > .container-fluid .row-fluid .nav-header',
			  :text => 'Sidebar')
		end

		it 'the footer should be rendered in the correct place' do
			visit '/board/index'
			page.should have_selector('body > .container-fluid:last-child footer.row-fluid',
			  :text => '&copy; Lionheart Studio and Brent Houghton')
		end
	end
end

