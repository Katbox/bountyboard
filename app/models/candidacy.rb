# == Schema Information
#
# Table name: candidacies
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Candidacy < ActiveRecord::Base
  attr_accessible :user_id, :bounty_id

  #Many to many join table between user and bounty.
  belongs_to :user
  belongs_to :bounty

  validates :user_id, presence: true
  validates :bounty_id, presence: true
end
