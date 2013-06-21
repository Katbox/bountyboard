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

# -*- encoding : utf-8 -*-
class Vote < ActiveRecord::Base
  attr_protected :id, :user_id, :bounty_id
  attr_accessible :vote_type

  # Relationships ==============================================================
  belongs_to :user
  belongs_to :bounty

  # Validations ================================================================
  validates :user_id, presence: true
  validates :bounty_id, presence: true
  validates_uniqueness_of :user_id, :scope => :bounty_id
end
