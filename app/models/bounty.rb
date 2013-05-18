# == Schema Information
#
# Table name: bounties
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  desc           :text             not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  rating         :boolean          default(FALSE), not null
#  is_private     :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  reject_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price_cents, :rating, :url, :private, :artist_id, :mood_ids
  attr_protected :user_id, :reject_id

  monetize :price_cents

  #OWNERSHIP OF A VOTE
  has_many :votes

  #OWNERSHIP OF A BOUNTY
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"

  #REJECTION OF A BOUNTY
  belongs_to :rejector, :foreign_key => "reject_id", :class_name => "User"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :artists, :through => :candidacies

  #PERSONALITY OF A BOUNTY
  has_many :personalities
  has_many :moods, :through => :personalities

  #CANDIDACIES MAY BE SAVED WHEN A BOUNTY IS SAVED
  accepts_nested_attributes_for :candidacies

  #VALIDATIONS
  validates :name, :desc, :price, :user_id, :presence => true

  def self.MAXIMUM_NAME_LENGTH
    30
  end
  validates :name, :length => {
    :minimum => 1,
  :maximum => Bounty.MAXIMUM_NAME_LENGTH,
  :message => "must be between 1 and 30 characters long"
  }

  def self.MAXIMUM_DESC_LENGTH
    5000
  end
  validates :desc, :length => {
    :minimum => 1,
  :maximum => Bounty.MAXIMUM_DESC_LENGTH,
  :message => "must be between 1 and 5000 characters long"
  }
  validates :is_private, :inclusion => {:in => [true, false]}
  validates :rating, :inclusion => {:in => [true, false]}

  def self.MINIMUM_PRICE
    5.00
  end
  validates :price,
    :numericality => {
      :greater_than_or_equal_to => self.MINIMUM_PRICE,
      message: "must be #{self.MINIMUM_PRICE} or more"
    }

end
