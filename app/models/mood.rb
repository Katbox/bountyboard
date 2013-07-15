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

    # Relationships ============================================================
    has_many :personalities, :inverse_of => :mood
    has_many :bounties, :through => :personalities

    # Validations ==============================================================
    validates :name, :presence => true
end
