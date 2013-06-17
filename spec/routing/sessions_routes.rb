# -*- encoding : utf-8 -*-

require 'spec_helper'

describe 'routing to sessions' do

  it 'should route successful login to SessionsController#create' do
    expect(:post => '/auth/browser_id/callback').to route_to(
      :controller => 'sessions',
      :action => 'create'
    )
  end

  it 'should route session delete requests to SessionsController#signOut' do
    expect(:post => '/auth/failure').to route_to(
      :controller => 'sessions',
      :action => 'authFailure'
    )
  end

  it 'should route session delete requests to SessionsController#signOut' do
    expect(:delete => '/sign_out').to route_to(
      :controller => 'sessions',
      :action => 'destroy'
    )
  end
end

