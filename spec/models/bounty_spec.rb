# == Schema Information
#
# Table name: bounties
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  desc           :text             not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  adult_only     :boolean          default(FALSE), not null
#  private        :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  completed_at   :datetime
#  complete_by    :datetime
#  tag_line       :string(255)      not null
#

require 'spec_helper'

describe Bounty do

  it { should respond_to(:name) }
  it { should respond_to(:tag_line) }
  it { should respond_to(:desc) }
  it { should respond_to(:price_cents) }
  it { should respond_to(:price) }
  it { should respond_to(:adult_only) }
  it { should respond_to(:url) }
  it { should respond_to(:private) }
  it { should respond_to(:user_id) }
  it { should respond_to(:completed_at) }
  it { should respond_to(:complete_by) }
  it { should respond_to(:score) }
  it { should respond_to(:vote_by) }
  it { should respond_to(:score) }
  it { should respond_to(:acceptor_candidacy) }

  it 'should not allow name to be too long' do
    bounty = FactoryGirl.build(:bounty, :name => '$' * (Bounty.MAXIMUM_NAME_LENGTH + 1))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:name)
  end

  it 'should not allow name to be too long' do
    bounty = FactoryGirl.build(:bounty, :tag_line => '$' * (Bounty.MAXIMUM_TAG_LENGTH + 1))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:tag_line)
  end

  it 'should not allow desc to be too long' do
    bounty = FactoryGirl.build(:bounty, :desc => '$' * (Bounty.MAXIMUM_DESC_LENGTH + 1))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:desc)
  end

  it 'should not allow price to be too low' do
    bounty = FactoryGirl.build(:bounty, :price => (Bounty.MINIMUM_PRICE - 0.01))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:price)
  end

  it 'should not allow price to be too high' do
    bounty = FactoryGirl.build(:bounty, :price => (Bounty.MAXIMUM_PRICE + 0.01))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:price)
  end

  it 'should not allow private to be anything other than true or false' do
    bounty = FactoryGirl.build(:bounty, :private => 'cheese')
    bounty.should be_valid
    bounty.adult_only.should == false
  end

  it 'should not allow adult_only to be anything other than true or false' do
    bounty = FactoryGirl.build(:bounty, :adult_only => 'cheese')
    bounty.should be_valid
    bounty.adult_only.should == false
  end

  it 'should not allow null values for its name property' do
    bounty = FactoryGirl.build(:bounty, :name => nil)
    bounty.should_not be_valid
    bounty.should have(2).error_on(:name)
  end

  it 'should not allow name to be empty' do
    bounty = FactoryGirl.build(:bounty, :name => '')
    bounty.should_not be_valid
    bounty.should have(2).error_on(:name)
  end

  it 'should not allow null values for its desc property' do
    bounty = FactoryGirl.build(:bounty, :desc => nil)
    bounty.should_not be_valid
    bounty.should have(2).error_on(:desc)
  end

  it 'should not allow desc to be empty' do
    bounty = FactoryGirl.build(:bounty, :desc => '')
    bounty.should_not be_valid
    bounty.should have(2).error_on(:desc)
  end

  it 'should not allow null values for its price_cents property' do
    bounty = FactoryGirl.build(:bounty, :price_cents => nil)
    bounty.should_not be_valid
    bounty.should have(1).error_on(:price_cents)
  end

  it 'should not allow null values for its adult_only property' do
    bounty = FactoryGirl.build(:bounty, :adult_only => nil)
    bounty.should_not be_valid
    bounty.should have(1).error_on(:adult_only)
  end

  it 'should not allow null values for its private property' do
    bounty = FactoryGirl.build(:bounty, :private => nil)

    bounty.should have(1).error_on(:private)
  end

  describe 'status' do
    before {
      @bounty = FactoryGirl.create(:bounty)
    }

    it 'should be Unclaimed' do
      @bounty.status.should == 'Unclaimed'
    end

    it 'should be Accepted' do
      @bounty.candidacies[0].accepted_at = 1.seconds.from_now
      @bounty.candidacies.each { |candidacy| candidacy.save! }
      @bounty.status.should == 'Accepted'
    end

    it 'should be Completed' do
      @bounty.url = "http://www.google.com"
      @bounty.save!
      @bounty.status.should == 'Completed'
    end
  end

  describe 'dates' do
    before {
      @bounty = FactoryGirl.create(:bounty)
    }

    it 'should not accept due dates in the past' do
      @bounty.complete_by = DateTime.now - 1
      @bounty.should_not be_valid
      @bounty.should have(1).error_on(:complete_by)
    end

    it 'should accept due dates in the future' do
      @bounty.complete_by = DateTime.now + 1
      @bounty.should be_valid
    end
  end

  describe 'methods' do
    before {
      @bounty = FactoryGirl.create(:bounty)
    }

    it 'should respond to private method' do
      @bounty.private = true
      @bounty.private?.should == true
      @bounty.private = false
      @bounty.private?.should == false
    end

    it 'should respond to abandoned method' do
      @bounty.abandoned?.should == false
      Candidacy.destroy_all( :bounty_id => @bounty.id )
      @bounty.reload
      @bounty.abandoned?.should == true
    end

    it 'should respond to acceptor_candidacy method' do
      @bounty.acceptor_candidacy.should == nil
      @bounty.candidacies[0].accepted_at = 1.seconds.from_now
      @bounty.candidacies[0].save!
      @bounty.acceptor_candidacy.should == @bounty.candidacies[0]
    end
  end

  describe '.viewable_by()' do
    before do
      @admin = FactoryGirl.create(:admin)
      @poster = FactoryGirl.create(:user)
      @unrelated_user = FactoryGirl.create(:user)
      @candidate_artist = FactoryGirl.create(:artist)
      @unrelated_artist = FactoryGirl.create(:artist)
      @public_bounty = FactoryGirl.create(:bounty,
        :owner => @poster,
        :artists => [ @candidate_artist ]
      )
      @private_bounty = FactoryGirl.create(:private_bounty,
        :owner => @poster,
        :artists => [ @candidate_artist ]
      )
    end

    it 'should let anyone view public bounties' do
      Bounty.viewable_by(nil).all.should include(@public_bounty)
      Bounty.viewable_by(@admin).all.should include(@public_bounty)
      Bounty.viewable_by(@poster).all.should include(@public_bounty)
      Bounty.viewable_by(@unrelated_user).all.should include(@public_bounty)
      Bounty.viewable_by(@candidate_artist).all.should include(@public_bounty)
      Bounty.viewable_by(@unrelated_artist).all.should include(@public_bounty)
    end

    it 'should prevent an unrelated user from viewing private bounties' do
      Bounty.viewable_by(nil).all.should_not include(@private_bounty)
      Bounty.viewable_by(@unrelated_user).all.should_not include(@private_bounty)
      Bounty.viewable_by(@unrelated_artist).all.should_not include(@private_bounty)
    end

    it 'should allow the poster to view their own private bounty' do
      Bounty.viewable_by(@poster).all.should include(@private_bounty)
    end

    it 'should allow a candidate artist to view a private bounty' do
      Bounty.viewable_by(@candidate_artist).all.should include(@private_bounty)
    end

    it 'should allow an admin to view a private bounty' do
      Bounty.viewable_by(@admin).all.should include(@private_bounty)
    end

  end

  describe '.viewable_by?()' do
    before do
      @admin = FactoryGirl.create(:admin)
      @poster = FactoryGirl.create(:user)
      @unrelated_user = FactoryGirl.create(:user)
      @candidate_artist = FactoryGirl.create(:artist)
      @unrelated_artist = FactoryGirl.create(:artist)
      @public_bounty = FactoryGirl.create(:bounty,
        :owner => @poster,
        :artists => [ @candidate_artist ]
      )
      @private_bounty = FactoryGirl.create(:private_bounty,
        :owner => @poster,
        :artists => [ @candidate_artist ]
      )
    end

    it 'should let anyone view public bounties' do
      @public_bounty.viewable_by?(nil).should == true
      @public_bounty.viewable_by?(@admin).should == true
      @public_bounty.viewable_by?(@poster).should == true
      @public_bounty.viewable_by?(@unrelated_user).should == true
      @public_bounty.viewable_by?(@candidate_artist).should == true
      @public_bounty.viewable_by?(@unrelated_artist).should == true
    end

    it 'should prevent an unrelated user from viewing private bounties' do
      @private_bounty.viewable_by?(nil).should == false
      @private_bounty.viewable_by?(@unrelated_user).should == false
      @private_bounty.viewable_by?(@unrelated_artist).should == false
    end

    it 'should allow the poster to view their own private bounty' do
      @private_bounty.viewable_by?(@poster).should == true
    end

    it 'should allow a candidate artist to view a private bounty' do
      @private_bounty.viewable_by?(@candidate_artist).should == true
    end

    it 'should allow an admin to view a private bounty' do
      @private_bounty.viewable_by?(@admin).should == true
    end

  end

  describe '.vote_by()' do
    before do
      @bounty = FactoryGirl.create(:bounty_with_vote)
    end

    it 'should return nil for a nil user' do
      @bounty.vote_by(nil).should == nil
    end
    it 'should return the vote cast by the voter' do
      the_vote = @bounty.votes[0]
      voter = the_vote.user
      @bounty.vote_by(voter).should == the_vote
    end
  end

end

