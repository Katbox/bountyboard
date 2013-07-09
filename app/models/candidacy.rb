# == Schema Information
#
# Table name: candidacies
#
#  id          :integer          not null, primary key
#  bounty_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :integer          not null
#  accepted_at :datetime
#

class Candidacy < ActiveRecord::Base

  # Relationships ==============================================================
  belongs_to :artist
  belongs_to :bounty

  # Validations ================================================================
  validates :artist_id, presence: true
  validates :bounty_id, presence: true
  validates :bounty_id, :uniqueness => { :scope => :artist_id }
  validate :validate_one_acceptor

  # Ensures that each bounty has only one acceptor at most.
  def validate_one_acceptor
    if accepted_at
      num_acceptors = Candidacy.where(
        'bounty_id=? AND accepted_at IS NOT NULL',
        self.bounty_id
      ).size

      if num_acceptors > 0
        errors.add(:accepted_at, "An acceptor already exists for this bounty")
      end
    end
  end
end
