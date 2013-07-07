Bountyboard::Application.routes.draw do

  root :to => 'Bounties#index'

  resources :artists
  resources :bounties
  resources :candidacies
  resources :votes
  resources :favorites

  # authentication routes
  match '/auth/:provider/callback', to: 'Sessions#create'
  match '/sign_out', to: 'Sessions#destroy', via: :delete
  match '/auth/failure', to: 'Sessions#auth_failure'
end

