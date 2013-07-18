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

  # Relationships ==============================================================
  belongs_to :mood, :inverse_of => :personalities
  belongs_to :bounty, :inverse_of => :personalities

  # Validations ================================================================
  validates :mood, presence: true
  validates :bounty, presence: true
  validates_uniqueness_of :mood_id, :scope => :bounty_id

  # Attributes =================================================================
  def self.MAXIMUM_MOODS
    2
  end

  def self.MINIMUM_MOODS
    1
  end
end
