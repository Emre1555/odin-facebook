Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships
  resources :friends, only: [:index, :destroy]

  resources :posts
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
