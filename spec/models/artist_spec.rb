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
#  admin         :boolean          default(FALSE), not null
#  active        :boolean
#

require 'spec_helper'

describe Artist do

  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:get_identifier) }
  it { should respond_to(:rememberToken) }
  it { should respond_to(:bio) }
  it { should respond_to(:bounty_rules) }
  it { should respond_to(:approved) }

  it 'should not allow null values for its name property' do
    artist = FactoryGirl.build(:artist, :name => nil)
    artist.should_not be_valid
    artist.should have(1).error_on(:name)
  end

  it 'should not allow null values for its approved property' do
    artist = FactoryGirl.build(:artist, :approved => nil)
    artist.should_not be_valid
    artist.should have(1).error_on(:approved)
  end

  it 'should not allow null values for its bio property' do
    artist = FactoryGirl.build(:artist, :bio => nil)
    artist.should_not be_valid
    artist.should have(1).error_on(:bio)
  end

  it 'should not allow null values for its bounty_rules property' do
    artist = FactoryGirl.build(:artist, :bounty_rules => nil)
    artist.should_not be_valid
    artist.should have(1).error_on(:bounty_rules)
  end
end

