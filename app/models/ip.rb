class Ip < ActiveRecord::Base
  attr_accessible :name, :desc, :rules, :artist_id

  belongs_to :artist
end
