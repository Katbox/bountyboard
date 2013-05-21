# encoding: UTF-8

require 'spec_helper'

describe 'bounty routes' do

  it 'should map the root URL to Bounty#show' do
    expect(:get => '/').to route_to(
      :controller => 'bounty',
      :action => 'show'
    )
  end
end


