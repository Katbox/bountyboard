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

  describe "New Bounty" do
    before {
      @artist1 = FactoryGirl.create(:artist, :name => "Artist1")
      @artist2 = FactoryGirl.create(:artist, :name => "Artist2")
      @artist3 = FactoryGirl.create(:artist, :name => "Artist3")
      @artist4 = FactoryGirl.create(:artist, :name => "Artist4")
      @mood1 = FactoryGirl.create(:mood, :name => "Mood1")
      @mood2 = FactoryGirl.create(:mood, :name => "Mood2")

      visit new_bounty_path
    }

    #  Top Nav Bar & Contents
    it { should have_selector('.navbar') }
    it { should have_selector('.brand') }

    # Header & Bounty Button
    it { should have_selector('.hero-unit') }

    # Bounty Post Area
    it { should have_selector('#bounty-post-area')}
    it { should have_selector('#bounty_artists_input') }
    it { should have_selector('label[for=bounty_artist_ids_1]', :text => "Artist1") }
    it { should have_selector('label[for=bounty_artist_ids_2]', :text => "Artist2") }
    it { should have_selector('label[for=bounty_artist_ids_3]', :text => "Artist3") }
    it { should have_selector('label[for=bounty_artist_ids_4]', :text => "Artist4") }
    it { should have_selector('#bounty_moods_input') }
    it { should have_selector('label[for=bounty_mood_ids_1]', :text => "Mood1") }
    it { should have_selector('label[for=bounty_mood_ids_2]', :text => "Mood2") }

    # Footer
    it { should have_selector('footer.row-fluid', :text => '© Lionheart Studio and Brent Houghton') }
    it { should have_selector('footer.row-fluid', :text => 'The Bounty Board is free software available under the open source AGPL license.') }
  end
end

