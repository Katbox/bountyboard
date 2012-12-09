Bountyboard::Application.routes.draw do
  get "board/index"
  root :to => 'Board#index'
end
