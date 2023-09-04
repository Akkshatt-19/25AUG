Rails.application.routes.draw do
  # Authentication routes
  post 'login', to: 'users#login'
  post 'signup', to: 'users#signup'

  # Users resource
  resources :users, only: [:show], shallow: true do
    post 'follow', on: :member
    post 'unfollow', on: :member
  end

  # Posts resource
  resources :posts, only: [:index, :create, :show, :update , :destroy] do
    resources :comments, only: [:create, :update, :destroy] do
      get 'edit', on: :member
    end
    resources :likes, only: [:index, :create, :destroy]
  end

  # Blocks resource
  resources :blocks, only: [:create, :destroy]

  # Custom route for creating follows
  post 'follows/:id', to: 'follows#post', as: 'user_follows'

  # Update and delete routes for users
  patch 'users/:id', to: 'users#update', as: 'update_user'
  delete 'users/:id', to: 'users#destroy', as: 'delete_user'
end
