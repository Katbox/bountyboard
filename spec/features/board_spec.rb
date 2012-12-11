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
			page.should have_selector('div.hero-unit h1',
			  :text => 'Welcome to the Bounty Board')
			page.should have_selector('div.hero-unit h2',
			  :text => 'A project that connects artists to fans and fans to the artwork they love.')
		end
	end
end

