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
    @bounty = FactoryGirl.create(:bounty)

    # Associate the maximum number of moods with the bounty.
  	(1..Personality.MAXIMUM_MOODS).each do |i|
	  mood = FactoryGirl.create(:mood)
	  FactoryGirl.create(:personality, :bounty_id => @bounty.id, :mood_id => mood.id)
    end
  }

  it 'should not allow a bounty to have more moods than MAXIMUM_MOODS' do
    new_mood = FactoryGirl.create(:mood)
	invalid_personality = FactoryGirl.build(:personality, :bounty_id => @bounty.id, :mood_id => new_mood.id)
	invalid_personality.should be_invalid
  end

  it 'should not allow the same mood to be associated with a bounty multiple times' do
    mood = Mood.all[1]
	invalid_personality = FactoryGirl.build(:personality, :bounty_id => @bounty.id, :mood_id => mood.id)
	invalid_personality.should be_invalid
  end
end
