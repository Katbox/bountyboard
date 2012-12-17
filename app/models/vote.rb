# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  bounty_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  attr_accessible :user_id, :bounty_id

  #OWNERSHIP OF A VOTE
  belongs_to :user

  #OWNERSHIP OF A VOTE
  belongs_to :bounty

end
