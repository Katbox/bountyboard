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

class Candidacy < ActiveRecord::Base
  attr_accessible :acceptor, :artist_id, :bounty_id

  #Many to many join table between artists and bounty.
  belongs_to :artist
  belongs_to :bounty

  validates :artist_id, presence: true
  validates :bounty_id, presence: true
  validates :bounty_id, :uniqueness => { :scope => :artist_id }
  validates :acceptor, :inclusion => {:in => [true, false]}
  validate :validate_one_acceptor

  # ensures that each bounty has only one acceptor at most
  def validate_one_acceptor
    if acceptor
      numberOfAcceptors = Candidacy.where(
        :bounty_id => bounty_id,
        :acceptor => true,
      ).size
      errors.add(:acceptor, " already exists for this bounty") if numberOfAcceptors > 0
    end
  end
end
