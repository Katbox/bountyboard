# == Schema Information
#
# Table name: personalities
#
#  id         :integer          not null, primary key
#  mood_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Personality do

  it { should respond_to(:id) }
  it { should respond_to(:mood) }
  it { should respond_to(:bounty) }

  before {
    @bountyWithMinMoods = FactoryGirl.create(:bounty)
    @bountyWithMaxMoods = FactoryGirl.create(:bounty)
    (@bountyWithMaxMoods.moods.length..(Personality.MAXIMUM_MOODS-1)).each do |i|
      mood = FactoryGirl.create(:mood)
      @bountyWithMaxMoods.moods.append(mood)
    end
  }

  it 'should not allow a bounty to have less than MINIMUM_MOODS' do
    # can't create a bounty with less than minimum moods
    expect {
      FactoryGirl.create(:bounty, :moods => [])
    }.to raise_error(ActiveRecord::RecordInvalid)

    # can't delete personalities to take a bounty below the minimum
    # moods
    @bountyWithMinMoods.should be_valid
    @bountyWithMinMoods.personalities.first.destroy
    @bountyWithMinMoods.reload
    @bountyWithMinMoods.should_not be_valid
    @bountyWithMinMoods.should have(1).error_on :moods
  end

  it 'should not allow a bounty to have more moods than MAXIMUM_MOODS' do
    @bountyWithMaxMoods.should be_valid
    @bountyWithMaxMoods.moods.append(FactoryGirl.create(:mood))
    @bountyWithMaxMoods.should be_invalid
  end

  it 'should not allow the same mood to be associated with a bounty multiple times' do
    mood = @bountyWithMinMoods.moods.first
    invalid_personality = FactoryGirl.build(:personality,
      :mood => mood,
      :bounty => @bountyWithMinMoods
    )
    invalid_personality.should be_invalid
  end

  it 'should not allow null values for its mood property' do
    personality = FactoryGirl.build(:personality,
      :mood => nil,
      :bounty => @bounty
    )
    personality.should_not be_valid
    personality.should have(1).error_on(:mood_id)
  end

  it 'should not allow null values for its bounty property' do
    mood = FactoryGirl.create(:mood)
    personality = FactoryGirl.build(:personality,
      :mood => mood,
      :bounty => nil
    )
    personality.should_not be_valid
    personality.should have(1).error_on(:bounty_id)
  end
end
