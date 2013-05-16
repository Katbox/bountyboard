# == Schema Information
#
# Table name: candidacies
#
#  id               :integer          not null, primary key
#  bounty_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  candidacy_detail_id :integer          not null
#  is_acceptor      :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Candidacy do

  it { should respond_to(:id) }
  it { should respond_to(:bounty_id) }
  it { should respond_to(:acceptor) }

  before {
    @bounty = FactoryGirl.create(:bounty)
	@artist = FactoryGirl.create(:user_with_artist_detail)
  }

  it 'should not allow null values for its acceptor property' do
    candidacy = FactoryGirl.build(:candidacy,
      :acceptor => nil,
      :bounty_id => @bounty.id,
      :artist_detail_id => @artist.artist_detail_id
    )
    candidacy.should_not be_valid
    candidacy.should have(1).error_on(:acceptor)
  end

end
