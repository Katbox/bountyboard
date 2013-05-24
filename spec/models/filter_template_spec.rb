# coding: utf-8

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

  it 'should not allow null values for its name property' do
    template = FactoryGirl.build(:filter_template, :name => nil)
    template.should_not be_valid
    template.should have(1).error_on(:name)
  end

  it 'should not allow null values for its sql property' do
    template = FactoryGirl.build(:filter_template, :sql => nil)
    template.should_not be_valid
    template.should have(1).error_on(:sql)
  end

  it 'should be readonly once saved to the database' do
    template = FactoryGirl.build(:filter_template)
    template.name = 'changing name before save is okay'
    template.save!
    template.name = 'changing name after save is not okay'
	lambda { template.save! }.should raise_error(ActiveRecord::ReadOnlyRecord)
  end

end
