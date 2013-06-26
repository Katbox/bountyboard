# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: bounties
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  desc           :text             not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  adult_only     :boolean          default(FALSE), not null
#  private        :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  completed_at   :datetime
#  complete_by    :datetime
#  score          :decimal(, )
#

class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price_cents, :adult_only, :url, :private, :mood_ids, :price, :artist_ids, :completed_at, :complete_by

  # Money gem. "price_cents" is the price of the bounty in cents.
  # The gem will apply proper formatting if the implicit "price" property is
  # used. Ex. @bounty.price_cents -> 100050 @bounty.price -> 1,000.50. Price
  # symbols like $ are accessed separately.
  monetize :price_cents

  # Relationships ==============================================================
  has_many :votes, :dependent => :destroy
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"
  has_many :candidacies, :dependent => :destroy
  has_many :artists, :through => :candidacies
  has_many :personalities, :dependent => :destroy
  has_many :moods, :through => :personalities

  # Attributes =================================================================
  def self.MAXIMUM_NAME_LENGTH
    25
  end

  def self.MAXIMUM_DESC_LENGTH
    5000
  end

  def self.MAXIMUM_PRICE
    1000000
  end

  def self.MINIMUM_PRICE
    5.00
  end

  # Validations ================================================================
  validates :name, :desc, :price, :user_id, :presence => true

  validates :name, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_NAME_LENGTH,
    :message => "must be between 1 and 25 characters long"
  }

  validates :desc, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_DESC_LENGTH,
    :message => "must be between 1 and 5000 characters long"
  }

  validates :private, :inclusion => {:in => [true, false]}

  validates :adult_only, :inclusion => {:in => [true, false]}

  validates :price,
    :numericality => {
      :greater_than_or_equal_to => self.MINIMUM_PRICE,
      message: "must be #{self.MINIMUM_PRICE} or more"
    }

  validates :price,
    :numericality => {
      :less_than_or_equal_to => self.MAXIMUM_PRICE,
      message: "must be #{self.MAXIMUM_PRICE} or less"
    }

  validates :status, :exclusion => {
    :in => 'Invalid',
    :message => 'Cannot save a bounty with status invalid.'
  }

  validate :validate_num_of_moods

  validate :due_date_in_future

  # If this bounty is not have the correct range of moods, throw an error.
  def validate_num_of_moods
    errors.add(:moods, "for this bounty exceeds #{Personality.MAXIMUM_MOODS}") if moods.length > Personality.MAXIMUM_MOODS
    errors.add(:moods, "for this bounty must be at least #{Personality.MINIMUM_MOODS}") if moods.length < Personality.MINIMUM_MOODS
  end

  # If the create_by date is in the past, throw an error.
  def due_date_in_future
    unless complete_by == nil
      errors.add(:complete_by, "is in the past. Specify a date in the future.") if complete_by < Time.now
    end
  end

  # Methods ====================================================================

  # Sets the rating of the bounty to the Lower bound of Wilson score confidence
  # interval for a Bernoulli parameter, invoked only when a bounty is voted
  # on to recalculate the rating.
  def setRating(pos, n, confidence)
    if n == 0
      return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    self[:score] = (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

  # Returns private or public based on the boolean private property.
  def private?
    return self[:private]
  end

  # Returns true if the bounty has no candidacies.
  def abandoned?
    self.candidacies.empty?
  end

  # Returns true if the specified user has already voted on this bounty.
  def voted_on?(id)
    votes = Vote.where(:user_id => id, :bounty_id => self[:id])
    if votes.count < 1
      return nil
    else
      return votes[0].vote_type
    end
  end

  # Returns the status of the bounty as a string. May either be Completed,
  # Accepted, or Unclaimed.
  def status
    accepted = candidacies.where( :acceptor => true ).length > 0
    completed = ((self.url != "") && (self.url != nil))
    if completed
      return 'Completed'
    elsif accepted
      return 'Accepted'
    else
      return 'Unclaimed'
    end
  end

  # Return the artist object that is the acceptor of this bounty. Return
  # nil if bounty is not accepted.
  def accepting_artist
    acceptor_candidacy = candidacies.where( :acceptor => true).first
    if acceptor_candidacy.nil?
      return nil
    else
      return acceptor_candidacy.artist
    end
  end

  # Return the date the bounty was accepted and nil if the bounty is unclaimed.
  def accepted_on
    acceptor_candidacy = candidacies.where( :acceptor => true).first
    if acceptor_candidacy.nil?
      return nil
    else
      return acceptor_candidacy.accepted_at
    end
  end

  # Bounty query filters
  #
  # Use these to get specific subsets of bounties. These
  # methods are chainable.
  class << self
    def cost_greater_than(limit)
      where('cost > ?', limit)
    end
  
    def cost_less_than(limit)
      where('cost < ?', limit)
    end
  
    def age_greater_than(limit)
      where('created_at > ?', limit.to_date)
    end
  
    def age_less_than(limit)
      where('created_at < ?', limit.to_date)
    end
  
    def only_adult_content()
      where( :adult_only => true )
    end
  
    def no_adult_content()
      where( :adult_only => false )
    end
  
    def viewable_by(user)
      if user.nil?
        where( :private => false )
      elsif user.admin
        where('1=1')
        # in Rails 4, you can simply use this line:
        # all
      elsif user.is_a?(Artist)
        joins(:candidacies).where(
          "private='f' OR user_id=? OR candidacies.artist_id=?",
          user.id,
          user.id
        )
      else
        where("private='f' OR user_id=?", user.id)
      end
    end
  end

  # an instance-level version of the viewable_by filter, this returns true if
  # this bounty can be viewed by the specified user (or by an anonymous user if
  # the user paramter is set to nil) and returns false otherwise
  def viewable_by?(user)
    if !self.private
      return true
    end
    if user
      if user.admin
        return true
      end
      viewable = (self.owner == user)
  	  if user.is_a?(Artist)
        viewable = viewable || self.artists.include?(user)
      end
      return viewable
    else
      return false
    end
  end
end

