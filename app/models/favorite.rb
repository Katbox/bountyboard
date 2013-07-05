# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
