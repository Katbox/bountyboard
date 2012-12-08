class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price, :rating, :vote
end
