class Taxonomy < ActiveRecord::Base
  attr_accessible :name

  #One to many relationship with bounty.
  has_many :bounties

  validates :name, presence: true
end
