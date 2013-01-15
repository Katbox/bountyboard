Bountyboard::Application.routes.draw do

  root :to => 'Board#index'

  match "/bounty" => "bounty#index"
  match "/bounty/new" => "bounty#new"
 
  # authentication routes
  match '/auth/:provider/callback', to: 'Sessions#create'
  match '/sign_out', to: 'Sessions#destroy', via: :delete
  match '/auth/failure', to: 'Sessions#authFailure'
end

