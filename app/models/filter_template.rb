# == Schema Information
#
# Table name: filter_templates
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sql        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FilterTemplate < ActiveRecord::Base

  attr_accessible :name, :sql

  validates :name, presence: true
  validates :sql, presence: true
  validates_uniqueness_of :name

  # FilterTemplates are readonly once saved to the database
  def readonly?
    persisted?
  end

end
