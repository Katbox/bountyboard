# encoding: UTF-8

class Status < ActiveRecord::Base
  attr_accessible :status

  #One to many relationship with bounty.
  has_many :bounties

  validates :status, presence: true
end
