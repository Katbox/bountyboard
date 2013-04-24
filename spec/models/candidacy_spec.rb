# == Schema Information
#
# Table name: candidacies
#
#  id               :integer          not null, primary key
#  bounty_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_detail_id :integer          not null
#  is_acceptor      :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Candidacy do

  it { should respond_to(:id) }
  it { should respond_to(:artist_detail_id) }
  it { should respond_to(:bounty_id) }
  it { should respond_to(:is_acceptor) }

end
