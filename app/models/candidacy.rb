# == Schema Information
#
# Table name: candidacies
#
#  id               :integer          not null, primary key
#  bounty_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_detail_id :integer
#

class Candidacy < ActiveRecord::Base
  attr_protected :id, :artist_id, :bounty_id

  #Many to many join table between artist details and bounty.
  belongs_to :artistDetails
  belongs_to :bounty

  validates :artist_id, presence: true
  validates :bounty_id, presence: true
end
