# encoding: UTF-8

require 'spec_helper'

describe 'Bounty' do

  subject { page }

  describe "Home Page" do
    before {
      @user = FactoryGirl.create(:user)
      @artist = FactoryGirl.create(:artist)
      @bounty = FactoryGirl.create(:bounty,
        :name => "My First Bounty",
        :desc => "My very first bounty ever.",
        :price => 9.99,
        :rating => false,
        :is_private => false,
        :user_id => @user.id
        )
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
    it { should have_selector('.bounty-square') }
    it { should have_selector('.bounty-square .ribbon', :text => "$9.99") }
    it { should have_selector('.bounty-square .name', :text => "My First Bounty") }
    it { should have_selector('.bounty-square .short-desc', :text => "My very first bounty ever.") }
    it { should have_selector('.bounty-square .read-more', :text => "Read More") }

    # Footer
    it { should have_selector('footer.row-fluid', :text => '© Lionheart Studio and Brent Houghton') }
    it { should have_selector('footer.row-fluid', :text => 'The Bounty Board is free software available under the open source AGPL license.') }
  end
end

