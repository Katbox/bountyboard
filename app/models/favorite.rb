class Favorite < ActiveRecord::Base
  attr_accessible :user_id, :bounty_id

  # Relationships ==============================================================
  belongs_to :user
  belongs_to :bounty

  # Validations ================================================================
  validates :user_id, presence: true
  validates :bounty_id, presence: true
  validates_uniqueness_of :user_id, :scope => :bounty_id

end
