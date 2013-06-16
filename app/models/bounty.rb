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
  has_many :candidacies
  has_many :artists, :through => :candidacies, :dependent => :destroy
  has_many :personalities
  has_many :moods, :through => :personalities, :dependent => :destroy

  # Attributes =================================================================
  def self.MAXIMUM_NAME_LENGTH
    30
  end

  def self.MAXIMUM_DESC_LENGTH
    5000
  end

  def self.MINIMUM_PRICE
    5.00
  end

  # Validations ================================================================
  validates :name, :desc, :price, :user_id, :presence => true

  validates :name, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_NAME_LENGTH,
    :message => "must be between 1 and 30 characters long"
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
    errors.add(:complete_by, "is in the past. Specify a date in the future.") if complete_by < Time.now
  end

  # Methods ====================================================================

  # Returns private or public based on the boolean private property.
  def private?
    return self[:private]
  end

  # Checks if an artist is a candidate for a bounty based on the artist's name.
  # Returns true if he is, and false if he isn't.
  def has_candidate?(name)
    artist = Artist.find_by_name(name)
    if artist
      candidacy = Candidacy.where(:artist_id => artist.id, :bounty_id => self[:id]).first
      if candidacy
        return true
      else
        return false
      end
    else
      return false
    end
  end

  # Returns true if the bounty has no candidacies.
  def is_abandoned?
    num_of_candidacies = Candidacy.where(:bounty_id => self[:id]).count
    if num_of_candidacies > 0
      return false
    end
    return true
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

  # Bounty query filters use these to get specific subsets of bounties. These
  # methods are chainable
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
end
