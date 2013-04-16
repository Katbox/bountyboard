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
#  private        :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  accept_id      :integer
#  reject_id      :integer
#  complete_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price_cents, :rating, :url, :private
  attr_protected :user_id, :accept_id, :reject_id, :complete_id

  monetize :price_cents

  #OWNERSHIP OF A VOTE
  has_many :votes

  #OWNERSHIP OF A BOUNTY
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"

  #ACCEPTANCE OF A BOUNTY
  belongs_to :acceptor, :foreign_key => "accept_id", :class_name => "User"

  #REJECTION OF A BOUNTY
  belongs_to :rejector, :foreign_key => "reject_id", :class_name => "User"

  #COMPLETION OF A BOUNTY
  belongs_to :completor, :foreign_key => "complete_id", :class_name => "User"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :artist_details, :through => :candidacies

  #PERSONALITY OF A BOUNTY
  has_many :personalities
  has_many :moods, :through => :personalities

  #CANDIDACIES MAY BE SAVED WHEN A BOUNTY IS SAVED
  accepts_nested_attributes_for :candidacies

  #VALIDATIONS
  validates :name, :desc, :price, :user_id, :presence => true
  validates :complete_id, :inclusion => { :in => proc { |p| [p.accept_id] } }, :allow_nil => true # The completor may only be the acceptor if present.

  validates :name, :length => {:minimum => 1, :maximum => 30, message: "must be between 1 and 30 characters long"}
  validates :desc, :length => {:minimum => 1, :maximum => 5000, message: "must be between 1 and 5000 characters long"}
  validates :price,
    :numericality => {
      :greater_than_or_equal_to => 5.00,
      message: "must be $5.00 or more"
    }
end
