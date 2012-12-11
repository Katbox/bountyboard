# encoding: UTF-8

class User < ActiveRecord::Base
  attr_accessible :name, :email

  #One to many relationship with bounty.
  has_many :bounties

  before_save { |user| user.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
