# == Schema Information
#
# Table name: artist_details
#
#  id          :integer          not null, primary key
#  bio         :text             not null
#  bountyRules :text             not null
#  approved    :boolean          default(FALSE), not null
#

require 'spec_helper'

describe ArtistDetail do

  it { should respond_to(:id) }
  it { should respond_to(:bio) }
  it { should respond_to(:bountyRules) }
  it { should respond_to(:approved) }

  it 'should only allow boolean values for its approved property' do
    artist = FactoryGirl.build(:artist_detail, :approved => true)
	artist.should be_valid
	artist = FactoryGirl.build(:artist_detail, :approved => false)
	artist.should be_valid
	artist = FactoryGirl.build(:artist_detail, :approved => "cheese")
	artist.approved.should == false
  end

  it 'should not allow null values for its approved property' do
	artist = FactoryGirl.build(:artist_detail, :approved => nil)
	artist.should_not be_valid
	artist.should have(1).error_on(:approved)
  end

  it 'should not allow null values for its bio property' do
    artist = FactoryGirl.build(:artist_detail, :bio => nil)
	artist.should_not be_valid
	artist.should have(1).error_on(:bio)
  end

  it 'should not allow null values for its bountyRules property' do
    artist = FactoryGirl.build(:artist_detail, :bountyRules => nil)
	artist.should_not be_valid
	artist.should have(1).error_on(:bountyRules)
  end

end

