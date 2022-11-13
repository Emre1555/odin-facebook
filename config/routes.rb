Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }

  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships
  resources :friends, only: [:index, :destroy]
  resources :likes, only:[ :create, :destroy]
  resources :users
  resources :posts do
    resources :comments
  end
    

  # Defines the root path route ("/")
  root "posts#index"
end
