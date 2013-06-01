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
#  is_private     :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price_cents, :adult_only, :url, :is_private, :mood_ids
  attr_protected :user_id

  monetize :price_cents

  #OWNERSHIP OF A VOTE
  has_many :votes, :dependent => :destroy

  #OWNERSHIP OF A BOUNTY
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :artists, :through => :candidacies, :dependent => :destroy

  #PERSONALITY OF A BOUNTY
  has_many :personalities
  has_many :moods, :through => :personalities, :dependent => :destroy

  #CANDIDACIES MAY BE SAVED WHEN A BOUNTY IS SAVED
  accepts_nested_attributes_for :candidacies

  #VALIDATIONS
  validates :name, :desc, :price, :user_id, :presence => true

  def get_url
    return self[:url] ? self[:url] : "This bounty is not yet completed!"
  end

  def get_private
    return self[:is_private] ? "private" : "public"
  end

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

  validates :adult_only, :inclusion => {:in => [true, false]}

  def self.MINIMUM_PRICE
    5.00
  end
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

  def validate_num_of_moods
    errors.add(:moods, "for this bounty exceeds #{Personality.MAXIMUM_MOODS}") if moods.length > Personality.MAXIMUM_MOODS
    errors.add(:moods, "for this bounty must be at least #{Personality.MINIMUM_MOODS}") if moods.length < Personality.MINIMUM_MOODS
  end

  def status
    accepted = candidacies.where( :acceptor => true ).length > 0
    completed = (self.url != "" && self.url != nil)
    if completed
      return 'Completed'
    elsif accepted
      return 'Accepted'
    else
      return 'Unclaimed'
    end
  end

  def accepting_artist
    acceptor_candidacy = candidacies.where( :acceptor => true)
  if acceptor_candidacy.nil?
      return nil
    else
      return acceptor_candidacy.first.artist
    end
  end

end
