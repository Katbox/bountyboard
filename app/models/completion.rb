# encoding: UTF-8

class Completion < ActiveRecord::Base
  attr_accessible :artist_id, :bounty_id, :taxonomy_id

  #Many to many connecting table with artist and bounty.
  belongs_to :artist
  belongs_to :bounty

  #One to many relationship with taxonomy to describe meaning of artist to bounty many to many.
  belongs_to :taxonomy

   validates :artist_id, presence: true
   validates :bounty_id, presence: true
   validates :taxonomy_id, presence: true
end
