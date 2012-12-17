# == Schema Information
#
# Table name: bounties
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  desc        :text             not null
#  price       :decimal(8, 2)    not null
#  rating      :boolean          default(FALSE), not null
#  private     :boolean          default(FALSE), not null
#  url         :string(255)
#  user_id     :integer          not null
#  accept_id   :integer
#  reject_id   :integer
#  complete_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Bounty < ActiveRecord::Base
  attr_accessible :name, :desc, :price, :rating, :url, :private, :user_id, :accept_id, :reject_id, :complete_id

  #OWNERSHIP OF A VOTE
  has_many :votes

  #OWNERSHIP OF A BOUNTY
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"

  #ACCEPTANCE OF A BOUNTY
  belongs_to :acceptor, :foreign_key => "accept_id", :class_name => "User"

  #REJECTION OF A BOUNTY
  belongs_to :rejector, :foreign_key => "reject_id", :class_name => "User"

  #COMPLETION OF A BOUNTY
  belongs_to :completor, :foreign_key => "complete_id", :class_name => "User"

  #CANDIDACY TO ACCEPT A BOUNTY
  has_many :candidacies
  has_many :users, :through => :candidacies

  validates :name, :desc, :price, :user_id, :presence => true
  validates :complete_id, :inclusion => { :in => proc { |p| [p.accept_id] } }, :allow_nil => true # The completor may only be the acceptor if present.
end
