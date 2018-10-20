Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  resources :games do
    collection do
      post 'move'
    end
  end
  resources :users
  root to: "users#new"
  resources :grids
end
