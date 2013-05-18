# == Schema Information
#
# Table name: candidacies
#
#  id         :integer          not null, primary key
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer          not null
#  acceptor   :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Candidacy do

  it { should respond_to(:id) }
  it { should respond_to(:bounty) }
  it { should respond_to(:acceptor) }

  before {
    @bounty = FactoryGirl.create(:bounty)
	@artist = FactoryGirl.create(:artist)
  }

  it 'should not allow null values for its bounty property' do
    candidacy = FactoryGirl.build(:candidacy,
      :bounty => nil,
      :artist => @artist
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:bounty_id)
  end

  it 'should not allow null values for its acceptor property' do
    candidacy = FactoryGirl.build(:candidacy,
      :acceptor => nil,
      :bounty => @bounty,
      :artist => @artist
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:acceptor)
  end

end
