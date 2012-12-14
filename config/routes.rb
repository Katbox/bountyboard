Bountyboard::Application.routes.draw do

  root :to => 'Board#index'

  # authentication routes
  match '/auth/:provider/callback', to: 'Sessions#create'
end

