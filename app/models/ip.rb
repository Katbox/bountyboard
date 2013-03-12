# == Schema Information
#
# Table name: ips
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  desc       :text             not null
#  rules      :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null


class Ip < ActiveRecord::Base
  attr_accessible :name, :desc, :rules
  attr_protected :id, :user_id

  #One to many relationship with user.
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
end
