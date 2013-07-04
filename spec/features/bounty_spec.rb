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
        :owner => @customer1
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :owner => @customer2
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :owner => @customer2
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :owner => @customer1
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
    it { should have_selector('.bounty-square .price-ribbon', :text => "$9.99") }
    it { should have_selector('.bounty-square .control-area') }
    it { should have_selector('.bounty-square .vote-controls') }
    it { should have_selector('.bounty-square .upvote') }
    it { should have_selector('.bounty-square .downvote') }
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
        :owner => @customer1
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :owner => @customer2
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :owner => @customer2
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :owner => @customer1
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
        :owner => @customer1
        )
      @adultBounty = FactoryGirl.create(:bounty,
        :name => "Adult Bounty",
        :desc => "Bounty#2",
        :price => 5.00,
        :adult_only => true,
        :private => false,
        :owner => @customer2
        )
      @privateBounty = FactoryGirl.create(:bounty,
        :name => "Private Bounty",
        :desc => "Bounty#3",
        :price => 500.00,
        :adult_only => false,
        :private => true,
        :owner => @customer2
        )
      @privateAdultBounty = FactoryGirl.create(:bounty,
        :name => "Private Adult Bounty",
        :desc => "Bounty#4",
        :price => 100.00,
        :adult_only => false,
        :private => true,
        :owner => @customer1
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
      @artist1 = FactoryGirl.create(:artist)
      @artist2 = FactoryGirl.create(:artist)
      @artist3 = FactoryGirl.create(:artist)
      @mood1 = FactoryGirl.create(:mood)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :owner => @customer1,
        :artists => [ @artist1, @artist2, @artist3 ],
        :moods => [ @mood1 ]
      )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @guest.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty)
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
      @artist1 = FactoryGirl.create(:artist)
      @artist2 = FactoryGirl.create(:artist)
      @artist3 = FactoryGirl.create(:artist)
      @mood1 = FactoryGirl.create(:mood)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :owner => @customer1,
        :artists => [ @artist1, @artist2, @artist3 ],
        :moods => [ @mood1 ]
      )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @customer1.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty)
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
      @artist1 = FactoryGirl.create(:artist)
      @artist2 = FactoryGirl.create(:artist)
      @artist3 = FactoryGirl.create(:artist)
      @mood1 = FactoryGirl.create(:mood)
      @normalBounty = FactoryGirl.create(:bounty,
        :name => "Normal Bounty",
        :desc => "Bounty#1",
        :price => 9.99,
        :adult_only => false,
        :private => false,
        :complete_by => DateTime.now + 5,
        :owner => @customer1,
        :artists => [ @artist1, @artist2, @artist3 ],
        :moods => [ @mood1 ]
      )

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @artist1.email
      })
      visit '/auth/browser_id'

      visit bounty_path(@normalBounty)
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

  describe "create page" do
    before {

      @customer1 = FactoryGirl.create(:user)
      @artist1 = FactoryGirl.create(:artist, :name => "Artist1")
      @artist2 = FactoryGirl.create(:artist, :name => "Artist2")
      @artist3 = FactoryGirl.create(:artist, :name => "Artist3")
      @artist4 = FactoryGirl.create(:artist, :name => "Artist4")
      @mood1 = FactoryGirl.create(:mood, :name => "Mood1")
      @mood2 = FactoryGirl.create(:mood, :name => "Mood2")
      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @customer1.email
      })
      visit '/auth/browser_id'
      visit new_bounty_path
    }

    describe 'should display a form to create a bounty' do
      it { should have_selector('#form-area')}
      it { should have_selector('#bounty_name_input') }
      it { should have_selector('#bounty_name_input #bounty_name') }
      it { should have_selector('#bounty_desc_input') }
      it { should have_selector('#bounty_desc_input #bounty_desc') }
      it { should have_selector('#bounty_private_input') }
      it { should have_selector('#bounty_private_input #bounty_private') }
      it { should have_selector('#bounty_complete_by_input') }
      it { should have_selector('#bounty_complete_by_input .fragment #bounty_complete_by_1i') }
      it { should have_selector('#bounty_complete_by_input .fragment #bounty_complete_by_2i') }
      it { should have_selector('#bounty_complete_by_input .fragment #bounty_complete_by_3i') }
      it { should have_selector('#bounty_artists_input') }
      it { should have_selector('#bounty_artists_input .choices label', :text => @artist1.name) }
      it { should have_selector('#bounty_artists_input .choices label', :text => @artist2.name) }
      it { should have_selector('#bounty_artists_input .choices label', :text => @artist3.name) }
      it { should have_selector('#bounty_artists_input .choices label', :text => @artist4.name) }
      it { should have_selector('#bounty_moods_input') }
      it { should have_selector('#bounty_moods_input label[for=bounty_mood_ids_1]', :text => @mood1.name) }
      it { should have_selector('#bounty_moods_input label[for=bounty_mood_ids_2]', :text => @mood2.name) }
      it { should have_selector('#form-area .control-panel .bounty-button', :text =>  "") }
      it { should have_selector('#form-area .control-panel .bounty-button', :text =>  "Back") }
    end
  end

end

