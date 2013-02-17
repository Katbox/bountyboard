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

  #Many to many join table between user and bounty.
  belongs_to :mood
  belongs_to :bounty

  validates :mood_id, presence: true
  validates :bounty_id, presence: true
end
