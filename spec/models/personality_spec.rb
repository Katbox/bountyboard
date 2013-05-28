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

  it 'should not allow a bounty to have more less than MINIMUM_MOODS' do
    @bountyWithMinMoods.should be_valid
    @bountyWithMinMoods.moods.first.destroy
    @bountyWithMinMoods.reload.should be_invalid
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
