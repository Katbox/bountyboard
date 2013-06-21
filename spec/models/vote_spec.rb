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

# -*- encoding : utf-8 -*-
require 'spec_helper'
include VotesHelper

describe Vote do

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:bounty_id) }
  it { should respond_to(:vote_type) }

  before {
    @user = FactoryGirl.create(:user)
    @bounty = FactoryGirl.create(:bounty)
  }

  it 'should not allow the same user to vote on a bounty multiple times' do
    vote = FactoryGirl.build(:vote,
      :user_id => @user.id,
      :bounty_id => @bounty.id
      )
    vote.should be_valid
    invalid_vote = FactoryGirl.build(:vote,
      :user_id => @user_id,
      :bounty_id => @bounty.id
      )
    invalid_vote.should be_invalid
  end

  it 'should update the score of a bounty' do
    score = @bounty.score
    vote = FactoryGirl.build(:vote,
      :user_id => @user.id,
      :bounty_id => @bounty.id,
      :vote_type => true
      )
    vote.save!
    @bounty.save
    update_bounty_scores
    @bounty.reload.score
    score.should_not eq(@bounty.reload.score)
  end
end
