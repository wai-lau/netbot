Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  resources :games 
  resources :users
  resources :moves
  root to: "users#new"
end
