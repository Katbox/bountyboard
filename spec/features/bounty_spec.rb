require 'spec_helper'

describe 'Bounty' do

  before {
    @generic_user = FactoryGirl.create(:user)
    @customer = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user, :admin)
    @normal_bounty = FactoryGirl.create(:bounty,
      :name => "Normal Bounty",
      :price => 9.99,
      :adult_only => false,
      :private => false,
      :owner => @customer,
      :complete_by => DateTime.strptime('2018-08-22', '%Y-%m-%d')
    )
    @adult_bounty = FactoryGirl.create(:bounty,
      :name => "Adult Bounty",
      :price => 5.00,
      :adult_only => true,
      :private => false,
      :owner => @customer
    )
    @private_bounty = FactoryGirl.create(:bounty,
      :name => "Private Bounty",
      :price => 500.00,
      :adult_only => false,
      :private => true,
      :owner => @customer
    )

    2.times do
      FactoryGirl.create(:candidacy, :bounty => @normal_bounty)
    end
    @normal_bounty.reload
  }


  describe 'index page' do
    before {
      @expensive_bounty = FactoryGirl.create(:bounty,
        :name => "Expensive Bounty",
        :price => 25000.00
      )
    }

    context 'when a guest visits' do
      before {
        visit root_path
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
        page.should have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty",
          :count => 1
        )
      end

      it 'should not display private bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Private Bounty"
        )
      end

      it 'should not display bounties with adult content' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty"
        )
      end
    end

    context 'when a generic user visits' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @generic_user.email
        })
        visit '/auth/browser_id'

        visit root_path
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
        page.should have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty",
          :count => 1
        )
      end

      it 'should not display private bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Private Bounty"
        )
      end

      it 'should not display bounties with adult content' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty"
        )
      end
    end

    context 'when a bounty owner visits' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @customer.email
        })
        visit '/auth/browser_id'

        visit root_path
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
        page.should have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty",
          :count => 1
        )
      end

      it 'should display private bounties owned by that user' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Private Bounty",
          :count => 1
        )
      end

      it 'should not display bounties with adult content' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty"
        )
      end
    end

    context 'when an admin visits' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @admin.email
        })
        visit '/auth/browser_id'

        visit root_path
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
        page.should have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty",
          :count => 1
        )
      end

      it 'should display private bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Private Bounty",
          :count => 1
        )
      end

      it 'should not display bounties with adult content' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty"
        )
      end
    end

    context 'with a price filter' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @generic_user.email
        })
        visit '/auth/browser_id'

        visit root_path + "?price_min=5.00&price_max=20000.00"
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
      end

      it 'shouldn\'t display bounties outside the filter price range' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty"
        )
      end

      it 'should not display private bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Private Bounty"
        )
      end

      it 'should not display bounties with adult content' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty"
        )
      end
    end

    context 'with adult content filtering set to allow all' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @generic_user.email
        })
        visit '/auth/browser_id'

        visit root_path + "?adult=all"
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display normal bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty",
          :count => 1
        )
        page.should have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty",
          :count => 1
        )
      end

      it 'should not display private bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Private Bounty"
        )
      end

      it 'should display bounties with adult content' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty",
          :count => 1
        )
      end
    end

    context 'with adult content filtering set to adult content only' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @generic_user.email
        })
        visit '/auth/browser_id'

        visit root_path + "?adult=adult"
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'shouldn\'t display non-adult bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Normal Bounty"
        )
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Expensive Bounty"
        )
      end

      it 'should\'t display private bounties' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => "Private Bounty"
        )
      end

      it 'should display bounties with adult content' do
        page.should have_selector(
          '.bounty-square .name',
          :text => "Adult Bounty",
          :count => 1
        )
      end
    end

    context 'with an ownership filter' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @expensive_bounty.owner.email
        })
        visit '/auth/browser_id'

        visit root_path + "?own=1"
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display owned bounties' do
        page.should have_selector(
          '.bounty-square .name',
          :text => @expensive_bounty.name,
          :count => 1
        )
      end

      it 'shouldn\'t display bounties owned by other users' do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @normal_bounty.name,
          :count => 1
        )
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @adult_bounty.name,
          :count => 1
        )
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @private_bounty.name,
          :count => 1
        )
      end
    end

    context 'with an artist\'s candidacy filter' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @normal_bounty.artists.first.email
        })
        visit '/auth/browser_id'

        visit root_path + "?may_accept=1"
      }

      it 'should display bounties with the correct structure' do
        page.should have_selector(
          '.bounty-square .name',
        )
        page.should have_selector(
          '.bounty-square .short-desc',
          :text => "Bounty Tag Line.",
        )
        page.should have_selector(
          '.bounty-square .price-ribbon',
        )
      end

      it 'should display bounties for which this artist is a candidate' do
        page.should have_selector(
          '.bounty-square .name',
          :text => @normal_bounty.name,
          :count => 1
        )
      end

      it "shouldn't display bounties for which this artist isn't a candidate" do
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @expensive_bounty.name,
          :count => 1
        )
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @adult_bounty.name,
          :count => 1
        )
        page.should_not have_selector(
          '.bounty-square .name',
          :text => @private_bounty.name,
          :count => 1
        )
      end
    end
  end

  describe 'show page for a normal unclaimed bounty' do

    context 'when visited by a guest' do
      before {
        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'should display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end

    context 'when visited by a generic user' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @generic_user.email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'should display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end

    context 'when visited by the poster' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @customer.email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'should display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'should display bounty update controls' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end

    context 'when visited by a non-candidate artist' do
      before {
        @artist = FactoryGirl.create(:artist)

        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @artist.email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'should display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end

    context 'when visited by a candidate artist' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @normal_bounty.artists[0].email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'should display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'should display artist controls' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end
  end

  describe 'show page for a normal claimed bounty' do
    before {
      acceptor_candidacy = @normal_bounty.candidacies.first
      acceptor_candidacy.accepted_at = 1.seconds.from_now
      acceptor_candidacy.save!
      @normal_bounty.reload
      @acceptor = acceptor_candidacy.artist
    }

    context 'when visited by a candidate artist who is not the acceptor' do
      before {
        non_accepting_artists = @normal_bounty.artists.all
        non_accepting_artists.delete(@acceptor)
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => non_accepting_artists[0].email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'shouldn\'t display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should_not have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should_not have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'shouldn\'t show a completion button' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end

    context 'when visited by the accepting artist' do
      before {
        OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
          :provider => 'browserid',
          :uid => @acceptor.email
        })
        visit '/auth/browser_id'

        visit bounty_path(@normal_bounty)
      }

      it 'should have the correct structure' do
        page.should have_selector('#bounty-show')
        page.should have_selector(
          '#bounty-show .name',
          :text => 'Normal Bounty'
        )
        page.should have_selector(
          '#bounty-show .desc',
          :text => 'Bounty description'
        )
      end

      it 'shouldn\'t display the bounty\'s candidacies' do
        @normal_bounty.artists.length.should == 3
        @normal_bounty.artists.each { |artist|
          page.should_not have_selector(
            '#bounty-show .candidacies',
            :text => artist.name
          )
        }
        page.should_not have_selector(
          '#bounty-show .candidacies',
          :text => @normal_bounty.price
        )
      end
      it 'should display the bounty\'s moods' do
        page.should have_selector(
          '#bounty-show .moods',
          :text => @normal_bounty.moods[0].name
        )
      end
      it 'should display the bounty\'s due date' do
        page.should have_selector(
          '#bounty-show .dates > *',
          :text =>  'This bounty must be finished by August 22, 2018'
        )
      end
      it 'should display a "Back" button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Back'
        )
      end
      it 'shouldn\'t display bounty update controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Update'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Delete'
        )
      end
      it 'shouldn\'t display artist controls' do
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Accept'
        )
        page.should_not have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Reject'
        )
      end
      it 'should show a completion button' do
        page.should have_selector(
          '#bounty-show .control-panel .bounty-button',
          :text => 'Complete'
        )
      end
    end
  end

  describe 'create page' do
    before {
      2.times do
        FactoryGirl.create(:artist)
      end
      3.times do
        FactoryGirl.create(:mood)
      end

      OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
        :provider => 'browserid',
        :uid => @customer.email
      })
      visit '/auth/browser_id'

      visit new_bounty_path
    }

    it 'should have the correct structure' do
      page.should have_selector('#form-area')
    end
    it 'should have a bounty name input' do
      page.should have_selector('#bounty_name_input')
      page.should have_selector('#bounty_name_input #bounty_name')
    end
    it 'should have a bounty description input' do
      page.should have_selector('#bounty_desc_input')
      page.should have_selector('#bounty_desc_input #bounty_desc')
    end
    it 'should have a privacy option' do
      page.should have_selector('#bounty_private_input')
      page.should have_selector('#bounty_private_input #bounty_private')
    end
    it 'should have a "complete by" input' do
      page.should have_selector('#bounty_complete_by_input')
      page.should have_selector(
        '#bounty_complete_by_input .fragment #bounty_complete_by_1i'
      )
      page.should have_selector(
        '#bounty_complete_by_input .fragment #bounty_complete_by_2i'
      )
      page.should have_selector(
        '#bounty_complete_by_input .fragment #bounty_complete_by_3i'
      )
    end
    it 'should have candidacy inputs' do
      page.should have_selector('#bounty_artists_input')
      Artist.all.each { |artist|
        page.should have_selector(
          '#bounty_artists_input .choices label',
          :text => artist.name
        )
      }
    end
    it 'should have mood inputs' do
      page.should have_selector('#bounty_moods_input')
      Mood.all.each { |mood|
        page.should have_selector(
          "#bounty_moods_input label[for=bounty_mood_ids_#{mood.id}]",
          :text => mood.name
        )
      }
    end
    it 'should have a submit button' do
      page.should have_selector(
        '#form-area .control-panel ' +
          '.bounty-button[type="submit"][value="Create Bounty"]'
      )
    end
    it 'should display a "Back" button' do
      page.should have_selector(
        '#form-area .control-panel .bounty-button',
        :text =>  'Back'
      )
    end
  end
end

