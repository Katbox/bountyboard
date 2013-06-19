# -*- encoding : utf-8 -*-

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
        :adult_only => false,
        :private => false,
        :user_id => @user.id
        )

      visit root_path
    }

  end

  describe "create page" do
    before {

      @artist1 = FactoryGirl.create(:artist, :name => "Artist1")
      @artist2 = FactoryGirl.create(:artist, :name => "Artist2")
      @artist3 = FactoryGirl.create(:artist, :name => "Artist3")
      @artist4 = FactoryGirl.create(:artist, :name => "Artist4")
      @mood = FactoryGirl.create(:mood, :name => "Mood1")
      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => 'test-user@example.com'
      })
      visit '/auth/browser_id'
      visit new_bounty_path
    }

    describe 'should display a form to create a bounty' do
      it { should have_selector('#form-area')}
      it { should have_selector('#bounty_artists_input') }
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
        :adult_only => false,
        :private => false,
        :user_id => @user.id
        )
      visit bounty_path(@bounty.id)
    }
    describe 'should display a page for the bounty' do
      # it { print @bounty.candidacies }
      it { should have_selector('#bounty-show')}
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
  end

end

