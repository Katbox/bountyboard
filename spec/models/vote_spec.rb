# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vote_type  :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Vote do

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:bounty_id) }
  it { should respond_to(:vote_type) }

  before do
    # set up a bounty with some upvotes and downvotes
    @bounty = FactoryGirl.create(:bounty)
    6.times do
      FactoryGirl.create(:vote, :vote_type => true,:bounty => @bounty )
    end
    2.times do
      FactoryGirl.create(:vote, :vote_type => false,:bounty => @bounty )
    end
  end

  it 'should not allow the same user to vote on a bounty multiple times' do
    invalid_vote = FactoryGirl.build(:vote,
      :user => @bounty.votes[0].user,
      :bounty => @bounty
    )
    invalid_vote.should be_invalid
  end

  describe 'that is an upvote' do
    it 'should increase its bounty\'s score' do
      old_score = @bounty.score
      FactoryGirl.create(:vote,
        :bounty => @bounty,
        :vote_type => true
      )
      @bounty.score.should > old_score
    end
  end

  describe 'that is a downvote' do
    it 'should decrease its bounty\'s score' do
      old_score = @bounty.score
      downvote = FactoryGirl.create(:vote,
        :bounty => @bounty,
        :vote_type => false
      )
      @bounty.score.should < old_score
    end
  end
end
