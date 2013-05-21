# == Schema Information
#
# Table name: bounties
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  desc           :text             not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  rating         :boolean          default(FALSE), not null
#  is_private     :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  reject_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Bounty do

  it { should respond_to(:name) }
  it { should respond_to(:desc) }
  it { should respond_to(:price_cents) }
  it { should respond_to(:rating) }
  it { should respond_to(:url) }
  it { should respond_to(:is_private) }
  it { should respond_to(:user_id) }
  it { should respond_to(:reject_id) }

  it 'should not allow name to be too long' do
    bounty = FactoryGirl.build(:bounty, :name => '$' * (Bounty.MAXIMUM_NAME_LENGTH + 1))
    bounty.should_not be_valid
    bounty.should have(1).error_on(:name)
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

  it 'should not allow rating to be anything other than true or false' do
    bounty = FactoryGirl.build(:bounty, :rating => 'cheese')
    bounty.should be_valid
    bounty.rating.should == false
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

  it 'should not allow null values for its rating property' do
    bounty = FactoryGirl.build(:bounty, :rating => nil)
    bounty.should_not be_valid
    bounty.should have(1).error_on(:rating)
  end

  it 'should not allow null values for its is_private property' do
    bounty = FactoryGirl.build(:bounty, :is_private => nil)
    bounty.should_not be_valid
    bounty.should have(1).error_on(:is_private)
  end

  describe 'status' do

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

    it 'should be Unclaimed' do
      @bounty.status.should == 'Unclaimed'
    end

    it 'should be Accepted' do
      @candidacy.acceptor = true
      @candidacy.save!
      @bounty.reload.status.should == 'Accepted'
    end

    it 'should be Accepted' do
      @bounty.reject_id = @artist.id
      @bounty.save!
      @bounty.reload.status.should == 'Rejected'
    end

    it 'should be Invalid if accepted and rejected' do
      @candidacy.acceptor = true
      @bounty.reject_id = @artist.id
      @candidacy.save!
      @bounty.save!
      @bounty.reload.status.should == 'Invalid'
    end

    it 'should be Invalid if completed and rejected' do
      @bounty.url = "http://uhoh.com"
      @bounty.reject_id = @artist.id
      @bounty.save!
      @bounty.reload.status.should == 'Invalid'
    end

  end
end

