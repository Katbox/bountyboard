# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vote_type  :boolean          default(FALSE), not null
#

class Vote < ActiveRecord::Base

  # Relationships ==============================================================
  belongs_to :user, :inverse_of => :votes
  belongs_to :bounty, :inverse_of => :votes

  # Validations ================================================================
  validates :user, presence: true
  validates :bounty, presence: true
  validates_uniqueness_of :user_id, :scope => :bounty_id

  validate :user_cant_vote_on_own_bounty

  def user_cant_vote_on_own_bounty
    if user == bounty.owner
      errors.add(:user, 'cannot vote on their own bounty.')
    end
  end
end
