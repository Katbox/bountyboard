# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  email         :string(255)      not null
#  permission_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email

  #OWNERSHIP OF A VOTE
  has_many :votes

  #OWNERSHIP OF AN INTELLECTUAL PROPERTY
  has_many :ips

  #OWNERSHIP OF A BOUNTY
  has_many :ownerships, :foreign_key => "user_id", :class_name => "Bounty"

  #ACCEPTANCE OF A BOUNTY
  has_many :acceptions, :foreign_key => "accept_id", :class_name => "Bounty"

  #REJECTION OF A BOUNTY
  has_many :rejections, :foreign_key => "reject_id", :class_name => "Bounty"

  #COMPLETION OF A BOUNTY
  has_many :completions, :foreign_key => "complete_id", :class_name => "Bounty"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :bounties, :through => :candidacies

  validates :email, presence: true

end
