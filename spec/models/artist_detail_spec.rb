# == Schema Information
#
# Table name: artist_details
#
#  id          :integer          not null, primary key
#  bio         :text             not null
#  bountyRules :text             not null
#  approved    :boolean          default(FALSE), not null
#

require 'spec_helper'

describe ArtistDetail do

  it { should respond_to(:id) }
  it { should respond_to(:bio) }
  it { should respond_to(:bountyRules) }
  it { should respond_to(:approved) }

end

