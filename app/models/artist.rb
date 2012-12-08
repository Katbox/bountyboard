class Artist < ActiveRecord::Base
  attr_accessible :name, :email, :password

  #Many to many relationship with bounty through completion.
  has_many :completions
  has_many :bounties, :through => :completions
end
