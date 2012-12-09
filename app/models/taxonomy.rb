class Taxonomy < ActiveRecord::Base
  attr_accessible :type

  #One to many relationship with bounty.
  has_many :bounties

  validates :type, presence: true
end
