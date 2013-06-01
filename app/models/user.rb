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
#  type          :string(255)
#  bio           :text             default(""), not null
#  bounty_rules  :text             default(""), not null
#  approved      :boolean          default(FALSE), not null
#  admin         :boolean          default(FALSE), not null
#  active        :boolean
#

class User < ActiveRecord::Base
  attr_accessible :name, :email
  attr_protected :id, :admin

  #OWNERSHIP OF A VOTE
  has_many :votes

  #OWNERSHIP OF A BOUNTY
  has_many :ownerships, :foreign_key => "user_id", :class_name => "Bounty"

  #REJECTION OF A BOUNTY
  has_many :rejections, :foreign_key => "reject_id", :class_name => "Bounty"

  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false

  before_save :createRememberToken

  def get_identifier
    return self[:name] ? self[:name] : self[:email]
  end

  def is_admin?
    return self[:admin]
  end

  def is_artist?
    return true if self[:type] == 'Artist'
  end

  private

  def createRememberToken
    self.rememberToken = SecureRandom.urlsafe_base64
  end

end

