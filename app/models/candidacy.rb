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
  attr_accessible :acceptor
  attr_protected :id, :artist_detail_id, :bounty_id

  #Many to many join table between artist details and bounty.
  belongs_to :artistDetail
  belongs_to :bounty

  validates :artist_detail_id, presence: true
  validates :bounty_id, presence: true
  validates :bounty_id, :uniqueness => { :scope => :artist_detail_id }
  validates :acceptor, :inclusion => {:in => [true, false]}
  validate :validate_one_acceptor

  # ensures that each bounty has only one acceptor at most
  def validate_one_acceptor
	numberOfAcceptors = Candidacy.where(
	  :bounty_id => bounty_id,
      :acceptor => true,
	).size
	errors.add(:acceptor, " already exists for this bounty") if numberOfAcceptors > 1
  end
end
