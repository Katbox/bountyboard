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

  # Relationships ==============================================================
  belongs_to :user, :inverse_of => :favorites
  belongs_to :bounty, :inverse_of => :favorites

  # Validations ================================================================
  validates :user, presence: true
  validates :bounty, presence: true
  validates_uniqueness_of :user_id, :scope => :bounty_id

end
