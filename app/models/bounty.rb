# == Schema Information
#
# Table name: bounties
#
#  id                   :integer          not null, primary key
#  name                 :string(255)      not null
#  desc                 :text             not null
#  price_cents          :integer          default(0), not null
#  price_currency       :string(255)      default("USD"), not null
#  adult_only           :boolean          default(FALSE), not null
#  private              :boolean          default(FALSE), not null
#  url                  :string(255)
#  user_id              :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  completed_at         :datetime
#  complete_by          :datetime
#  tag_line             :string(255)      not null
#  artwork_file_name    :string(255)
#  artwork_content_type :string(255)
#  artwork_file_size    :integer
#  artwork_updated_at   :datetime
#  preview_file_name    :string(255)
#  preview_content_type :string(255)
#  preview_file_size    :integer
#  preview_updated_at   :datetime
#

include VotesHelper

class Bounty < ActiveRecord::Base
  attr_accessible :name, :tag_line, :desc, :artwork, :preview, :price_cents, :adult_only, :url, :private, :mood_ids, :price, :artist_ids, :completed_at, :complete_by

  # Paperclip gem. This ties the four properties "artwork_file_name",
  # "artwork_content_type", "artwork_file_size", and "artwork_updated_at" to a
  # single "artwork" property.
  has_attached_file :artwork, :styles => { :thumb => "280x200>" }
  has_attached_file :preview, :styles => { :standard => "280x200>" }

  # Money gem. "price_cents" is the price of the bounty in cents.
  # The gem will apply proper formatting if the implicit "price" property is
  # used. Ex. @bounty.price_cents -> 100050 @bounty.price -> 1,000.50. Price
  # symbols like $ are accessed separately.
  monetize :price_cents

  # Relationships ==============================================================
  has_many :votes, :dependent => :destroy, :inverse_of => :bounty
  belongs_to :owner, {
    :foreign_key => "user_id",
    :class_name => "User",
    :inverse_of => :ownerships
  }
  has_many :candidacies, :dependent => :destroy, :inverse_of => :bounty
  has_many :artists, :through => :candidacies
  has_many :personalities, :dependent => :destroy, :inverse_of => :bounty
  has_many :moods, :through => :personalities
  has_many :favorites, :dependent => :destroy, :inverse_of => :bounty
  has_many :users, :through => :favorites

  # Attributes =================================================================
  def self.MAXIMUM_NAME_LENGTH
    40
  end

  def self.MAXIMUM_TAG_LENGTH
    160
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
  validates :name, :desc, :price, :owner, :presence => true

  validates :name, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_NAME_LENGTH,
    :message => "must be between 1 and #{self.MAXIMUM_NAME_LENGTH} characters long"
  }

  validates :tag_line, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_TAG_LENGTH,
    :message => "must be between 1 and #{self.MAXIMUM_TAG_LENGTH} characters long"
  }

  validates :desc, :length => {
    :minimum => 1,
    :maximum => Bounty.MAXIMUM_DESC_LENGTH,
    :message => "must be between 1 and #{self.MAXIMUM_DESC_LENGTH} characters long"
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

  validate :completed_bounty_must_have_artwork

  # If this bounty is not have the correct range of moods, throw an error.
  def validate_num_of_moods
    errors.add(:moods, "for this bounty exceeds #{Personality.MAXIMUM_MOODS}") if moods.length > Personality.MAXIMUM_MOODS
    errors.add(:moods, "for this bounty must be at least #{Personality.MINIMUM_MOODS}") if moods.length < Personality.MINIMUM_MOODS
  end

  # If the create_by date is in the past, throw an error.
  def due_date_in_future
    if complete_by && complete_by < DateTime.now
      errors.add(:complete_by, 'is in the past. Specify a date in the future.')
    end
  end

  def completed_bounty_must_have_artwork
    if completed_at && !url
      errors.add(:url, 'must be assigned for a completed bounty.')
    end
  end

  before_save do
    # automatically assign a completion date when artwork is attached to a
    # bounty
    if url && !completed_at
      self.completed_at = DateTime.now
    end
  end

  # Methods ====================================================================

  # Returns a float giving the rating of the bounty to the Lower bound of
  # Wilson score confidence interval for a Bernoulli parameter. This is the
  # rating method made famous by Reddit's "best" sort algorithm.
  def score
    Rails.cache.fetch "/bounty/#{self.id}/score",
      :expires_in => 15.minutes.to_i,
      :race_condition_ttl => 15.seconds.to_i do

      all_votes = self.votes.all
      total_votes = all_votes.length
      positive_votes = all_votes.count { |vote|
        vote.vote_type == VoteType::UPVOTE
      }

      if total_votes == 0
        return 0.0
      end

      z = 1.96
      # the number 1.96 is hard-coded for performance, but is calculated from
      # this formula:
      # confidence = 0.95
      # z = Statistics2.pnormaldist(1-(1-confidence)/2)

      phat = positive_votes/total_votes.to_f
      (phat + z*z/(2*total_votes) - z * Math.sqrt((phat*(1-phat)+z*z/(4*total_votes))/total_votes))/(1+z*z/total_votes)
    end
  end

  # Returns private or public based on the boolean private property.
  def private?
    return self[:private]
  end

  # Returns true if the bounty has no candidacies.
  def abandoned?
    self.candidacies.empty?
  end

  # Returns true if the specified user can vote on this bounty, false
  # otherwise.
  def can_vote?(user)
    user && self.owner != user && self.votes.find_index { |vote|
      vote.user == user
    }
  end

  # Returns the vote cast for this bounty by the specified user, or
  # nil if the user hasn't voted on this bounty.
  def vote_by(user)
    if user
      self.votes.find { |vote| vote.user == user }
    end
  end

  # Returns the favorite object if the specified user favorited this bounty.
  def favored_by(user)
    if user
      self.favorites.find { |favorite| favorite.user == user }
    end
  end

  # Returns the status of the bounty as a string. May either be Completed,
  # Accepted, or Unclaimed.
  def status
    if self.url || self.completed_at
      'Completed'
    else
      if self.acceptor_candidacy
        'Accepted'
      else
        'Unclaimed'
      end
    end
  end

  # Returns the candidacy that accepted this bounty, or nil if this bounty is
  # not currently accepted by any artist.
  def acceptor_candidacy
    self.candidacies.all.select { |candidacy|
      candidacy.accepted_at
    }.first
  end

  def artwork_from_url(url)
    self.artwork = URI.parse(url)
  end

  # Bounty query filters
  #
  # Use these to get specific subsets of bounties. These
  # methods are chainable.
  class << self
    def price_greater_than(limit)
      where('price_cents > ?', limit * 100)
    end

    def price_less_than(limit)
      where('price_cents < ?', limit * 100)
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

    def owned_by(owner)
      where( :user_id => owner.id )
    end

    def only_unclaimed()
      joins(<<-sql).where('acceptors.id IS NULL').uniq()
      LEFT JOIN candidacies AS acceptors 
        ON (acceptors.bounty_id=bounties.id AND acceptors.accepted_at IS NOT NULL)
      sql
    end

    def only_accepted()
      where('url IS NULL')
        .joins(:candidacies).where('candidacies.accepted_at IS NOT NULL')
        .uniq
    end

    def only_completed()
      where('url IS NOT NULL')
    end

    # status should be one of the following: "Unclaimed", "Accepted",
    # "Completed"; if status is not in this list then no filtering will be done
    def only_status(status)

      # normalize the status string to lower case
      status = status.downcase

      if status == 'unclaimed'
        only_unclaimed()
      elsif status == 'accepted'
        only_accepted()
      elsif status == 'completed'
        only_completed()
      else
        # this can be replaced with the simpler "all" in Rails 4
        where('1=1')
      end
    end

    def may_accept(artist)
      joins(:candidacies).where(
        'candidacies.artist_id=?',
        artist.id
      ).uniq.only_unclaimed()
    end

    def viewable_by(user)
      if user.nil?
        where( :private => false )
      elsif user.admin
        # in Rails 4, you can replace the awkward "where(1=1)" line with "all"
        where('1=1')
      elsif user.is_a?(Artist)
        joins(:candidacies).where(
          "private=FALSE OR user_id=? OR candidacies.artist_id=?",
          user.id,
          user.id
        ).uniq
      else
        where("private=FALSE OR user_id=?", user.id)
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

