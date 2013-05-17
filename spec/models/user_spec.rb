# encoding: UTF-8
# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  rememberToken    :string(255)
#  artist_detail_id :integer
#


require 'spec_helper'

describe User do

  it { should respond_to(:id) }
  it { should respond_to(:artist_detail) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:rememberToken) }


  it 'should not allow null values for its email property' do
    user = FactoryGirl.build(:user, :email => nil)
    user.should_not be_valid
    user.should have(1).error_on(:email)
  end

  it 'should generate a rememberToken on save' do
    user = FactoryGirl.build(:user)
	user.rememberToken.should be_blank
    user.save!
    user.rememberToken.should_not be_blank
  end

  it 'should fetch the correct identifier for named and anonymous users' do
    anonymous_user = FactoryGirl.build(:user)
    named_user = FactoryGirl.build(:user, :name => 'Named User')
    anonymous_user.getIdentifier().should == anonymous_user.email
    named_user.getIdentifier().should == 'Named User'
  end
end

