# encoding: UTF-8

require 'spec_helper'

describe 'Bounty' do

  subject { page }

  describe "show all" do
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

    describe 'should display the nav bar' do
      it { should have_selector('.navbar') }
      it { should have_selector('.brand') }
      it { should have_selector('.persona-login-button', :text => "Sign In with Persona") }
      it { should_not have_selector('.login-notify-area') }
    end

    describe 'should display the page header and sign-in button' do
      it { should have_selector('.hero-unit') }
      it { should have_selector('.btn.btn-large.btn-primary', :text => "Sign In to Post Your Bounty") }
    end

    describe 'should display existing bounties' do
      it { should have_selector('.bounty-square') }
      it { should have_selector('.bounty-square .ribbon', :text => "$9.99") }
      it { should have_selector('.bounty-square .name', :text => "My First Bounty") }
      it { should have_selector('.bounty-square .short-desc', :text => "My very first bounty ever.") }
      it { should have_selector('.bounty-square .read-more', :text => "Read More") }
    end

    describe 'should display the footer' do
      it { should have_selector('footer.row-fluid', :text => '© Lionheart Studio, Nixie Bishop, and Brent Houghton') }
      it { should have_selector('footer.row-fluid', :text => 'The Bounty Board is free software available under the open source AGPL license.') }
    end
  end

  describe "create page" do
    before {
      @artist1 = FactoryGirl.create(:artist, :name => "Artist1")
      @artist2 = FactoryGirl.create(:artist, :name => "Artist2")
      @artist3 = FactoryGirl.create(:artist, :name => "Artist3")
      @artist4 = FactoryGirl.create(:artist, :name => "Artist4")
      @mood = FactoryGirl.create(:mood, :name => "Mood1")
      visit new_bounty_path
    }

    describe 'should display a form to create a bounty' do
      it { should have_selector('#bounty-page-area')}
      it { should have_selector('#bounty_artists_input') }
      it { should have_selector('label[for=bounty_artist_ids_1]', :text => "Artist1") }
      it { should have_selector('label[for=bounty_artist_ids_2]', :text => "Artist2") }
      it { should have_selector('label[for=bounty_artist_ids_3]', :text => "Artist3") }
      it { should have_selector('label[for=bounty_artist_ids_4]', :text => "Artist4") }
      it { should have_selector('#bounty_moods_input') }
      it { should have_selector('label[for=bounty_mood_ids_1]', :text => "Mood1") }
    end
  end

  describe "show bounty" do
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
      visit bounty_path(@bounty.id)
    }
    describe 'should display a form to create a bounty' do
      it { should have_selector('#bounty-page-area')}
      #TODO Create tests for selectors and content when inerface is redone.
    end
  end

  describe "destroy" do
    before {
      @user = FactoryGirl.create(:user, :name => 'User1')
      @artist = FactoryGirl.create(:artist, :name => 'Artist1')
      @bounty = FactoryGirl.create(:bounty, :name => 'Bounty1')
      @bounty.owner = @user
      @mood = FactoryGirl.create(:mood, :name => "Mood1")
      @vote = FactoryGirl.create(:vote,
        :user_id => @user.id,
        :bounty_id => @bounty.id
        )
      @candidacy = FactoryGirl.create(:candidacy,
        :acceptor => false,
        :bounty => @bounty,
        :artist => @artist
      )
      @personality = FactoryGirl.create(:personality,
        :mood => @mood,
        :bounty => @bounty
      )
    }

    # describe 'should delete bounty and dependencies' do
    #   Bounty.all.should_not be_empty
    #   Personality.all.should_not be_empty
    #   Candidacy.all.should_not be_empty
    #   Vote.all.should_not be_empty
    #   @bounty.destroy()
    #   Bounty.all.should be_empty
    #   Personality.all.should be_empty
    #   Candidacy.all.should be_empty
    #   Vote.all.should be_empty
    # end
  end

end

