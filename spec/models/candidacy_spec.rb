# == Schema Information
#
# Table name: candidacies
#
#  id         :integer          not null, primary key
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer          not null
#  acceptor   :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Candidacy do

  # Verify that Candidacy responds to its properties.
  it { should respond_to(:id) }
  it { should respond_to(:bounty) }
  it { should respond_to(:acceptor) }

  before {
    @bounty = FactoryGirl.create(:bounty)
    @artist = FactoryGirl.create(:artist)
  }

  # Verify that bounties only have one 'acceptor' through candidacies.
  it 'should not allow more than one acceptor per bounty' do
    candidacy1 = FactoryGirl.build(:candidacy,
      :acceptor => true,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy1.should be_valid
    candidacy1.save!

    artist2 = FactoryGirl.create(:artist)
    candidacy2 = FactoryGirl.build(:candidacy,
      :acceptor => true,
      :bounty => @bounty,
      :artist => artist2
    )
    candidacy2.should_not be_valid
    candidacy2.should have(1).error_on(:acceptor)
  end

  # Verify that bounty -> candidacy relationships are unique.
  it 'should not allow more than one acceptor per bounty' do
    candidacy1 = FactoryGirl.build(:candidacy,
      :acceptor => true,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy1.should be_valid
    candidacy1.save!

    candidacy2 = FactoryGirl.build(:candidacy,
      :acceptor => true,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy2.should_not be_valid
    candidacy2.should have(1).error_on(:bounty_id)
  end

  #Verify that acceptors accept only expected values.
  it 'should not allow rating to be anything other than true or false' do
    candidacy2 = FactoryGirl.build(:candidacy,
      :acceptor => 'cheese',
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy2.should be_valid
    candidacy2.acceptor.should == false
  end

  # Verify that not null properties do not accept null.
  it 'should not allow null values for its bounty property' do
    candidacy = FactoryGirl.build(:candidacy,
      :bounty => nil,
      :artist => @artist
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:bounty_id)
  end

  it 'should not allow null values for its acceptor property' do
    candidacy = FactoryGirl.build(:candidacy,
      :acceptor => nil,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:acceptor)
  end
end
