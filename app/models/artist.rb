# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  rememberToken :string(255)
#  type          :string(255)
#  bio           :text             default(""), not null
#  bounty_rules  :text             default(""), not null
#  approved      :boolean          default(FALSE), not null
#  admin         :boolean          default(FALSE), not null
#  active        :boolean
#

class Artist < User
  attr_accessible :bio, :bounty_rules, :approved, :active

  # Relationships ==============================================================
  has_many :candidacies, :inverse_of => :artist
  has_many :bounties, :through => :candidacies

  # Validations ================================================================
  validates :bio, presence: true
  validates :bounty_rules, presence: true
  validates :approved, :inclusion => {:in => [true, false]}
  validates :active, :inclusion => {:in => [true, false]}

  # The "name" property is optional for users but required for artists
  validates :name, presence: true
end

