# == Schema Information
#
# Table name: moods
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Mood do

  # Verify that Mood responds to its properties.
  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:personalities) }
  it { should respond_to(:bounties) }

  # Verify that not null properties do not accept null.
  it 'should not allow null values for its name property' do
    mood = FactoryGirl.build(:mood,
      :name => nil,
    )
    mood.should_not be_valid
    mood.should have(1).error_on(:name)
  end
end
