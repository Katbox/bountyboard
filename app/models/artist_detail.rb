# == Schema Information
#
# Table name: artist_details
#
#  id          :integer          not null, primary key
#  bio         :text             not null
#  bountyRules :text             not null
#  approved    :boolean          default(FALSE), not null
#

class ArtistDetail < ActiveRecord::Base
  attr_accessible :bio, :bountyRules, :approved

  has_one :user

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :bounties, :through => :candidacies

  def name
      user.name
  end

  validates :bio, presence: true
  validates :bountyRules, presence: true
  validates :approved, :inclusion => {:in => [true, false]}
end

