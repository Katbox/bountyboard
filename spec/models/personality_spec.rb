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

  # Verify that Personality responds to its properties.
  it { should respond_to(:id) }
  it { should respond_to(:mood) }
  it { should respond_to(:bounty) }

  before {
    @bounty = FactoryGirl.create(:bounty)

    # Associate the maximum number of moods with the bounty.
    @moods = []
    (1..Personality.MAXIMUM_MOODS).each do |i|
      mood = FactoryGirl.create(:mood)
      FactoryGirl.create(:personality, :bounty_id => @bounty.id, :mood_id => mood.id)
    @moods.push(mood)
    end
  }

    # Verify that a mood cannot have more than the defined maximum number of moods.
    it 'should not allow a bounty to have more moods than MAXIMUM_MOODS' do
    new_mood = FactoryGirl.create(:mood)
    invalid_personality = FactoryGirl.build(
      :personality,
      :bounty => @bounty,
      :mood => new_mood
    )
    invalid_personality.should be_invalid
  end

  # Verify that a mood cannot be associated with a bounty multiple times.
  it 'should not allow the same mood to be associated with a bounty multiple times' do
    invalid_personality = FactoryGirl.build(
      :personality,
      :bounty => @bounty,
      :mood => @moods[0]
    )
    invalid_personality.should be_invalid
  end

  # Verify that not null properties do not accept null.
  it 'should not allow null values for its mood property' do
    personality = FactoryGirl.build(:personality,
      :mood => nil,
      :bounty => @bounty
    )
    personality.should_not be_valid
    personality.should have(1).error_on(:mood_id)
  end

  it 'should not allow null values for its bounty property' do
    personality = FactoryGirl.build(:personality,
      :mood => @moods[0],
      :bounty => nil
    )
    personality.should_not be_valid
    personality.should have(1).error_on(:bounty_id)
  end
end
