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
    # set up a user, a bounty, and a number of moods
    @user = User.create( :email => 'anonymous@example.com' )
	(1..Personality.MAXIMUM_MOODS + 1).each do |i|
	  Mood.create( :name => i, :id => i )
	end
    @bounty = Bounty.create( :user_id => @user.id, :name => 'name', :desc => 'desc', :price => 10.00 )
  }

  it 'should not be able to associate more moods to a bounty than allowed' do
    # associate the maximum number of moods with the bounty
	(1..Personality.MAXIMUM_MOODS).each do |i|
	  new_personality = Personality.new( :bounty_id => @bounty.id, :mood_id => i )
	  new_personality.should be_valid
	  new_personality.save
	end

	# then add one more mood to the bounty and make sure it fails
    invalid_personality = Personality.new( :bounty_id => @bounty.id, :mood_id => (Personality.MAXIMUM_MOODS + 1) )
	invalid_personality.should_not be_valid
  end

end
