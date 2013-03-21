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

require 'spec_helper'

describe FilterTemplate do

  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:sql) }

end
