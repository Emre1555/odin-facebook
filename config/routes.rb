Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'omniauth_callbacks' }

  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friendships
  resources :friends, only: [:index, :destroy]
  resources :likes, only:[ :create, :destroy]
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  

  resources :posts do
    resources :comments
  end

  # Defines the root path route ("/")
  root "posts#index"
end
