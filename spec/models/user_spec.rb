# encoding: UTF-8
# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rememberToken :string(255)
#  type          :string(255)
#  bio           :text             default(""), not null
#  bounty_rules  :text             default(""), not null
#  approved      :boolean          default(FALSE), not null
#

require 'spec_helper'

describe User do

  # Verify that User responds to its properties.
  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:get_identifier) }
  it { should respond_to(:rememberToken) }

  # Verify that a User generates a remember token on save for session peristence.
  it 'should generate a rememberToken on save' do
    user = FactoryGirl.build(:user)
    user.rememberToken.should be_blank
    user.save!
    user.rememberToken.should_not be_blank
  end

  # Verify get_identifier function returns correct identifier if Name is present.
  it 'should fetch the correct identifier for named and anonymous users' do
    anonymous_user = FactoryGirl.build(:user)
    named_user = FactoryGirl.build(:user, :name => 'Named User')
    anonymous_user.get_identifier().should == anonymous_user.email
    named_user.get_identifier().should == 'Named User'
  end

  # Verify that not null properties do not accept null.
  it 'should not allow null values for its email property' do
    user = FactoryGirl.build(:user, :email => nil)
    user.should_not be_valid
    user.should have(1).error_on(:email)
  end
end

