class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price, :rating, :vote
  #One to many relationship with user.
  belongs_to :user

  #One to many relationship with status.
  belongs_to :status

  #One to many relationship with taxonomy.
  belongs_to :taxonomy

  #Many to many relationship with artist through completion.
  has_many :completions
  has_many :artists, :through => :completions

  validates :name, presence: true
  validates :desc, presence: true
  validates :price, presence: true
  validates :rating, presence: true
  validates :vote, presence: true
end
