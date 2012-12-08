class User < ActiveRecord::Base
  attr_accessible :name, :email

  #One to many relationship with bounty.
  has_many :bounties
end
