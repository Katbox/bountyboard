# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :boolean          default(FALSE), not null
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Vote do

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:bounty_id) }

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
end
