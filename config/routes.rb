Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships
  resources :friends, only: [:index, :destroy]
  resources :likes, only:[ :create, :destroy]

  

  resources :posts do
    resources :comments
  end
  
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
