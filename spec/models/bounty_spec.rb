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
#  private        :boolean          default(FALSE), not null
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
  it { should respond_to(:private) }
  it { should respond_to(:user_id) }
  it { should respond_to(:reject_id) }

  before {
    @bounty = FactoryGirl.build(:bounty)
  }

  it 'should not allow null values for its name property' do
	@bounty.name = nil
	@bounty.should_not be_valid
	@bounty.should have(2).error_on(:name)
  end

  it 'should not allow name to be empty' do
	@bounty.name = ''
	@bounty.should_not be_valid
	@bounty.should have(2).error_on(:name)
  end

  it 'should not allow name to be too long' do
	@bounty.name = '$' * (Bounty.MAXIMUM_NAME_LENGTH + 1)
	@bounty.should_not be_valid
	@bounty.should have(1).error_on(:name)
  end

  it 'should not allow null values for its desc property' do
	@bounty.desc = nil
	@bounty.should_not be_valid
	@bounty.should have(2).error_on(:desc)
  end

  it 'should not allow desc to be empty' do
	@bounty.desc = ''
	@bounty.should_not be_valid
	@bounty.should have(2).error_on(:desc)
  end

  it 'should not allow desc to be too long' do
    @bounty.desc = '$' * (Bounty.MAXIMUM_DESC_LENGTH + 1)
	@bounty.should_not be_valid
	@bounty.should have(1).error_on(:desc)
  end

  it 'should not allow null values for its price_cents property' do
	@bounty.price_cents = nil
	@bounty.should_not be_valid
	@bounty.should have(1).error_on(:price_cents)
  end

  it 'should not allow null values for its rating property' do
	@bounty.rating = nil
	@bounty.should_not be_valid
	@bounty.should have(1).error_on(:rating)
  end

  it 'should only allow boolean values for its rating property' do
	@bounty.rating = true
	@bounty.should be_valid
	@bounty.rating = false
	@bounty.should be_valid
	@bounty.rating = "cheese"
	@bounty.rating.should == false
  end

  it 'should not allow null values for its private property' do
	@bounty.private = nil
	@bounty.should_not be_valid
	@bounty.should have(1).error_on(:private)
  end

  it 'should only allow boolean values for its private property' do
    @bounty.private = true
	@bounty.should be_valid
    @bounty.private = false
	@bounty.should be_valid
    @bounty.private = "cheese"
	@bounty.private.should == false
  end

end


