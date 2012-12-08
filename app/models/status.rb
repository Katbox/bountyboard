class Status < ActiveRecord::Base
  attr_accessible :status

  #One to many relationship with bounty.
  has_many :bounties
end
