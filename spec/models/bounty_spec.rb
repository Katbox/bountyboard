# == Schema Information
#
# Table name: bounties
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  desc           :text             not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  rating         :boolean          default(FALSE), not null
#  private        :boolean          default(FALSE), not null
#  url            :string(255)
#  user_id        :integer          not null
#  reject_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Bounty do

	it { should respond_to(:name) }
	it { should respond_to(:desc) }
	it { should respond_to(:price_cents) }
	it { should respond_to(:rating) }
	it { should respond_to(:url) }
	it { should respond_to(:private) }
	it { should respond_to(:user_id) }
	it { should respond_to(:reject_id) }
end


