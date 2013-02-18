Bountyboard::Application.routes.draw do

  root :to => 'Board#index'

  resources :bounties


  # authentication routes
  match '/auth/:provider/callback', to: 'Sessions#create'
  match '/sign_out', to: 'Sessions#destroy', via: :delete
  match '/auth/failure', to: 'Sessions#authFailure'
end

