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
    # SETUP

    #1 USER
    @user = User.new( :email => 'anonymous@example.com' )
    @user.id = 1
    @user.save

    #3 MOODS
    (1..Personality.MAXIMUM_MOODS + 1).each do |i|
      @mood = Mood.new( :name => i)
      @mood.id = i
      @mood.save
    end

    #1 BOUNTY
    @bounty = Bounty.new( :name => 'name', :desc => 'desc', :price => 10.00 )
    @bounty.user_id = @user.id
    @bounty.save
  }

  it 'should not be able to let a bounty have more moods than the MAXIMUM_MOODS!' do
    # Associate the maximum number of moods with the bounty.
  	(1..Personality.MAXIMUM_MOODS).each do |i|
  	  new_personality = Personality.new()
      new_personality.bounty_id = @bounty.id
      new_personality.mood_id = i
      new_personality.save
  	  new_personality.should be_valid
    end

      invalid_personality = Personality.new()
      invalid_personality.bounty_id = @bounty.id
      invalid_personality.mood_id = 3
      invalid_personality.save
      invalid_personality.should be_invalid
  end

  it 'should not allow the same mood to be associated with a bounty multiple times!' do
    personality1 = Personality.new()
    personality1.bounty_id = @bounty.id
    personality1.mood_id = 1
  	personality1.should be_valid
  	personality1.save

    personality2 = Personality.new()
    personality2.bounty_id = @bounty.id
    personality2.mood_id = 1
  	personality2.should be_invalid
  end
end
