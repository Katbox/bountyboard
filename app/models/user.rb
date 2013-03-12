# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rememberToken :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email
  attr_protected :id

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
  validates_uniqueness_of :email, :case_sensitive => false

  before_save :createRememberToken

  def getIdentifier
    return self[:name] ? self[:name] : self[:email]
  end

  private

    def createRememberToken
		self.rememberToken = SecureRandom.urlsafe_base64
	end

end

