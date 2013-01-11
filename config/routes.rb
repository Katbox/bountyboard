Bountyboard::Application.routes.draw do

  root :to => 'Board#index'

  match "/bounty" => "bounty#index"
 

  # authentication routes
  match '/auth/:provider/callback', to: 'Sessions#create'
  match '/auth/failure', to: 'Sessions#auth_failure'
end

