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
  attr_protected :id
  attr_accessible :bio, :bountyRules, :approved

  belongs_to :user

  #ACCEPTANCE OF A BOUNTY
  has_many :acceptions, :foreign_key => "accept_id", :class_name => "Bounty"

  #REJECTION OF A BOUNTY
  has_many :rejections, :foreign_key => "reject_id", :class_name => "Bounty"

  #COMPLETION OF A BOUNTY
  has_many :completions, :foreign_key => "complete_id", :class_name => "Bounty"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :bounties, :through => :candidacies

  validates :bio, presence: true
  validates :bountyRules, presence: true
  validates :approved, presence: true
end

