# == Schema Information
#
# Table name: moods
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mood < ActiveRecord::Base
    attr_accessible :name
    attr_protected :id

    #PERSONALITY OF A BOUNTY
    has_many :personalities
    has_many :bounties, :through => :personalities

    #VALIDATIONS
    validates :name, :presence => true

end
