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

class Candidacy < ActiveRecord::Base
  attr_accessible :is_acceptor
  attr_protected :id, :artist_detail_id, :bounty_id

  #Many to many join table between artist details and bounty.
  belongs_to :artistDetail
  belongs_to :bounty

  validates :artist_detail_id, presence: true
  validates :bounty_id, presence: true
  validates :bounty_id, :uniqueness => { :scope => :artist_detail_id }
  validate :validate_one_acceptor

  # ensures that each bounty has only one acceptor at most
  def validate_one_acceptor
	numberOfAcceptors = Candidacy.where(
	  :bounty_id => bounty_id,
      :is_acceptor => true,
	).size
	errors.add(:is_acceptor, " already exists for this bounty") if numberOfAcceptors > 1
  end
end
