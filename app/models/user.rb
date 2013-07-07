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

  # Relationships ==============================================================
  has_many :votes
  has_many :ownerships, :foreign_key => "user_id", :class_name => "Bounty"
  has_many :rejections, :foreign_key => "reject_id", :class_name => "Bounty"
  has_many :favorites
  has_many :bounties, :through => :favorites

  # Validations ================================================================
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false

  # Token to allow session persistence.
  before_save :createRememberToken

  # Returns the name of the user if provided, email if not.
  def get_identifier
    return self[:name] ? self[:name] : self[:email]
  end

  # Returns if the user is an admin. Returns nil if not.
  def admin?
    return self[:admin]
  end

  private

  # Create a token to be used with session persistence.
  def createRememberToken
    self.rememberToken = SecureRandom.urlsafe_base64
  end

end

