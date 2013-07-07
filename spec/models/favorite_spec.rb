# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Favorite do
    it { should respond_to(:id) }
    it { should respond_to(:user_id) }
    it { should respond_to(:bounty_id) }

    before {
        @user = FactoryGirl.create(:user)
        @bounty = FactoryGirl.create(:bounty)
      }

    it 'should allow a valid favorite to save' do
        favorite = FactoryGirl.build(:favorite,
            :bounty => @bounty,
            :user => @user
        )
        favorite.should be_valid
    end

    it 'should not allow a duplicate favorite to save' do
        favorite1 = FactoryGirl.build(:favorite,
            :bounty => @bounty,
            :user => @user
        )
        favorite1.should be_valid
        favorite1.save
        favorite2 = FactoryGirl.build(:favorite,
            :bounty => @bounty,
            :user => @user
        )
        favorite2.should_not be_valid
    end


end
