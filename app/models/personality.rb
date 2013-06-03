# == Schema Information
#
# Table name: personalities
#
#  id         :integer          not null, primary key
#  mood_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Personality < ActiveRecord::Base
  attr_accessible :mood_id, :bounty_id

  # Relationships ==============================================================
  belongs_to :mood
  belongs_to :bounty

  # Validations ================================================================
  validates :mood_id, presence: true
  validates :bounty_id, presence: true
  validates_uniqueness_of :mood_id, :scope => :bounty_id

  # Attributes =================================================================
  def self.MAXIMUM_MOODS
    2
  end

  def self.MINIMUM_MOODS
    1
  end
end
