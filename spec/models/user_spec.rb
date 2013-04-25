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
#


require 'spec_helper'

describe User do

  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:rememberToken) }


  before {
    @named_user = User.new(name: 'Named User', email: 'nameduser@example.com')
    @anonymous_user = User.new(email: 'anonymous@example.com')
  }

  describe 'remember token' do
    before { @named_user.save }
    it { @named_user.rememberToken.should_not be_blank }
  end

  describe 'correct identifier for named user' do
    it { @named_user.getIdentifier().should == @named_user.name }
  end

  describe 'correct identifier for anonymous user' do
    it { @anonymous_user.getIdentifier().should == @anonymous_user.email }
  end
end

