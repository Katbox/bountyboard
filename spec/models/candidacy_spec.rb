# == Schema Information
#
# Table name: candidacies
#
#  id          :integer          not null, primary key
#  bounty_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :integer          not null
#  accepted_at :datetime
#

require 'spec_helper'

describe Candidacy do

  it { should respond_to(:id) }
  it { should respond_to(:bounty) }
  it { should respond_to(:accepted_at) }

  before {
    @bounty = FactoryGirl.create(:bounty)
    @artist = FactoryGirl.create(:artist)
  }

  it 'should not allow more than one acceptor per bounty' do
    candidacy1 = FactoryGirl.build(:candidacy,
      :accepted_at => 1.seconds.from_now,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy1.should be_valid
    candidacy1.save!

    artist2 = FactoryGirl.create(:artist)
    candidacy2 = FactoryGirl.build(:candidacy,
      :accepted_at => 2.seconds.from_now,
      :bounty => @bounty,
      :artist => artist2
    )
    candidacy2.should_not be_valid
    candidacy2.should have(1).error_on(:accepted_at)
  end

  it 'should not allow null values for its bounty property' do
    candidacy = FactoryGirl.build(:candidacy,
      :bounty => nil,
      :artist => @artist
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:bounty_id)
  end

  it 'should not allow null values for its artist property' do
    candidacy = FactoryGirl.build(:candidacy,
      :bounty => @bounty,
      :artist => nil
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:artist_id)
  end
end
