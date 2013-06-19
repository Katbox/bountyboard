# -*- encoding : utf-8 -*-

require 'spec_helper'

describe 'Bounty' do

  subject { page }

  describe "guest viewing index" do
    before {
      @guest = FactoryGirl.create(:user)
      @customer1 = FactoryGirl.create(:user)
      @customer2 = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :user_id => @customer1.id
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :user_id => @customer2.id
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer2.id
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer1.id
        )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @guest.email
      })
      visit '/auth/browser_id'

      visit root_path
    }

    it { should have_selector('#bounty-list')}
    it { should have_selector('.bounty-square')}
    it { should have_selector('.bounty-square .name', :text => "Normal Bounty") }
    it { should have_selector('.bounty-square .short-desc', :text => "Bounty#1") }
    it { should have_selector('.bounty-square .ribbon', :text => "$9.99") }
    it { should have_selector('.bounty-square .control-area') }
    it { should have_selector('.bounty-square .vote-controls') }
    it { should have_selector('.bounty-square .upvote') }
    it { should have_selector('.bounty-square .downvote') }
    it { should have_selector('.bounty-square .read-more-button') }
    it { should have_selector('.bounty-square .name', :text => "Adult Bounty") }
    it { should_not have_selector('.bounty-square .name', :text => "Private Bounty") }
    it { should_not have_selector('.bounty-square .name', :text => "Private Adult Bounty") }

 end

 describe "customer viewing index" do
    before {
      @guest = FactoryGirl.create(:user)
      @customer1 = FactoryGirl.create(:user)
      @customer2 = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :user_id => @customer1.id
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :user_id => @customer2.id
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer2.id
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer1.id
        )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @customer1.email
      })
      visit '/auth/browser_id'

      visit root_path
    }

    it { should have_selector('#bounty-list')}
    it { should have_selector('.bounty-square')}
    it { should have_selector('.bounty-square .name', :text => "Normal Bounty") }
    it { should have_selector('.bounty-square .name', :text => "Adult Bounty") }
    it { should_not have_selector('.bounty-square .name', :text => "Private Bounty") }
    it { should have_selector('.bounty-square .name', :text => "Private Adult Bounty") }

  end

  describe "admin viewing index" do
    before {
      @guest = FactoryGirl.create(:user)
      @customer1 = FactoryGirl.create(:user)
      @customer2 = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :user_id => @customer1.id
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :user_id => @customer2.id
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer2.id
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :user_id => @customer1.id
        )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @admin.email
      })
      visit '/auth/browser_id'

      visit root_path
    }

    it { should have_selector('#bounty-list')}
    it { should have_selector('.bounty-square')}
    it { should have_selector('.bounty-square .name', :text => "Normal Bounty") }
    it { should have_selector('.bounty-square .name', :text => "Adult Bounty") }
    it { should have_selector('.bounty-square .name', :text => "Private Bounty") }
    it { should have_selector('.bounty-square .name', :text => "Private Adult Bounty") }

  end

  describe "guest bounty show" do
    before {
      @guest = FactoryGirl.create(:user)
      @customer1 = FactoryGirl.create(:user)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :user_id => @customer1.id
        )
      @artist1 = @normalBounty.artists[0]
      @artist2 = @normalBounty.artists[1]
      @artist3 = @normalBounty.artists[2]
      @mood1 = @normalBounty.moods[0]

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @guest.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty.id)
    }

    it { should have_selector('#bounty-show')}
    it { should have_selector('#bounty-show .name', :text => "Normal Bounty")}
    it { should have_selector('#bounty-show .desc', :text => "Bounty#1")}
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist1.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist2.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist3.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @normalBounty.price) }
    it { should have_selector('#bounty-show .moods', :text =>  @mood1.name) }
    it { should have_selector('#bounty-show .dates', :text =>  "This bounty must be finished by") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Back") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Update") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Delete") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Accept") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Reject") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Complete") }
  end

  describe "owner bounty show" do
    before {
      @customer1 = FactoryGirl.create(:user)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :user_id => @customer1.id
        )
      @artist1 = @normalBounty.artists[0]
      @artist2 = @normalBounty.artists[1]
      @artist3 = @normalBounty.artists[2]
      @mood1 = @normalBounty.moods[0]

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @customer1.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty.id)
    }

    it { should have_selector('#bounty-show')}
    it { should have_selector('#bounty-show .name', :text => "Normal Bounty")}
    it { should have_selector('#bounty-show .desc', :text => "Bounty#1")}
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist1.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist2.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist3.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @normalBounty.price) }
    it { should have_selector('#bounty-show .moods', :text =>  @mood1.name) }
    it { should have_selector('#bounty-show .dates', :text =>  "This bounty must be finished by") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Back") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Update") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Delete") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Accept") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Reject") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Complete") }
  end

  describe "artist bounty show unclaimed" do
    before {
      @customer1 = FactoryGirl.create(:user)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :user_id => @customer1.id
        )
      @artist1 = @normalBounty.artists[0]
      @artist2 = @normalBounty.artists[1]
      @artist3 = @normalBounty.artists[2]
      @mood1 = @normalBounty.moods[0]

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @artist1.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty.id)
    }

    it { should have_selector('#bounty-show')}
    it { should have_selector('#bounty-show .name', :text => "Normal Bounty")}
    it { should have_selector('#bounty-show .desc', :text => "Bounty#1")}
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist1.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist2.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @artist3.name) }
    it { should have_selector('#bounty-show .candidacies', :text =>  @normalBounty.price) }
    it { should have_selector('#bounty-show .moods', :text =>  @mood1.name) }
    it { should have_selector('#bounty-show .dates', :text =>  "This bounty must be finished by") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Back") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Update") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Delete") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Accept") }
    it { should have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Reject") }
    it { should_not have_selector('#bounty-show .control-panel .bounty-button', :text =>  "Complete") }
  end

  # describe "create page" do
  #   before {

  #     @artist1 = FactoryGirl.create(:artist, :name => "Artist1")
  #     @artist2 = FactoryGirl.create(:artist, :name => "Artist2")
  #     @artist3 = FactoryGirl.create(:artist, :name => "Artist3")
  #     @artist4 = FactoryGirl.create(:artist, :name => "Artist4")
  #     @mood = FactoryGirl.create(:mood, :name => "Mood1")
  #     OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
  #       :provider => 'browserid',
  #       :uid => 'test-user@example.com'
  #     })
  #     visit '/auth/browser_id'
  #     visit new_bounty_path
  #   }

  #   describe 'should display a form to create a bounty' do
  #     it { should have_selector('#form-area')}
  #     it { should have_selector('#bounty_artists_input') }
  #     it { should have_selector('#bounty_moods_input') }
  #     it { should have_selector('label[for=bounty_mood_ids_1]', :text => "Mood1") }
  #   end
  # end

  # describe "show bounty" do
  #   before {
  #     @user = FactoryGirl.create(:user)
  #     @artist = FactoryGirl.create(:artist)
  #     @bounty = FactoryGirl.create(:bounty,
  #       :name => "My First Bounty",
  #       :desc => "My very first bounty ever.",
  #       :price => 9.99,
  #       :adult_only => false,
  #       :private => false,
  #       :user_id => @user.id
  #       )
  #     visit bounty_path(@bounty.id)
  #   }
  #   describe 'should display a page for the bounty' do
  #     # it { print @bounty.candidacies }
  #     it { should have_selector('#bounty-show')}
  #     #TODO Create tests for selectors and content when inerface is redone.
  #   end
  # end

  # describe "destroy" do
  #   before {
  #     @user = FactoryGirl.create(:user, :name => 'User1')
  #     @artist = FactoryGirl.create(:artist, :name => 'Artist1')
  #     @bounty = FactoryGirl.create(:bounty, :name => 'Bounty1')
  #     @bounty.owner = @user
  #     @mood = FactoryGirl.create(:mood, :name => "Mood1")
  #     @vote = FactoryGirl.create(:vote,
  #       :user_id => @user.id,
  #       :bounty_id => @bounty.id
  #       )
  #     @candidacy = FactoryGirl.create(:candidacy,
  #       :acceptor => false,
  #       :bounty => @bounty,
  #       :artist => @artist
  #     )
  #     @personality = FactoryGirl.create(:personality,
  #       :mood => @mood,
  #       :bounty => @bounty
  #     )
  #   }
  # end

end

