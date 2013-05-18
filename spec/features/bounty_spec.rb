# encoding: UTF-8

require 'spec_helper'

describe 'Bounty' do

  subject { page }

  describe "Home Page" do
    before {
      visit root_path
    }

    #  Top Nav Bar & Contents
    it { should have_selector('.navbar') }
    it { should have_selector('.brand') }
    it { should have_selector('.persona-login-button', :text => "Sign In with Persona") }
    it { should_not have_selector('.login-notify-area') }

    # Header & Bounty Button
    it { should have_selector('.hero-unit') }
    it { should have_selector('.btn.btn-large.btn-primary', :text => "Sign In to Post Your Bounty") }

    # Side Nav Bar & Contents
    it { should have_selector('article.sidebar-nav') }
    # it { should have_selector('li.nav-header'), :text => "Bounty Filters" }
    # it { should have_selector('li.nav-header'), :text => "Sort Bounties" }

    # Bounty Display Area
    it { should have_selector('.bounty-display-area') }

    # Footer
    it { should have_selector('footer.row-fluid', :text => '© Lionheart Studio and Brent Houghton') }
    it { should have_selector('footer.row-fluid', :text => 'The Bounty Board is free software available under the open source AGPL license.') }
  end
end

