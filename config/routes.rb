Bountyboard::Application.routes.draw do

  root :to => 'Board#index'

  # authentication routes
  match '/auth/browser_id/callback', to: 'sessions#create'
end

