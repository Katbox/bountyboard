# encoding: UTF-8

class Artist < ActiveRecord::Base
  attr_accessible :name, :email, :password, :desc, :rules
  #has_secure_password

  before_save { |artist| artist.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #One to many relationship with Ips.
  has_many :ips

  #Many to many relationship with bounty through completion.
  has_many :completions
  has_many :bounties, :through => :completions

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
