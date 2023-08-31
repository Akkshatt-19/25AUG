Rails.application.routes.draw do
  
  resources :users
  post 'user/login', to: 'users#login'
  post 'user/signup', to: 'users#signup'

  resources :blocks
  resources :follows
  resources :posts
  post 'users/:user_id/follows/:id', to: 'follows#post'
  
  resources :users do
    resources :posts, only: [:create, :update, :show, :destroy]
    resources :follows
  end
  
  resources :users do
    resources :posts, only: [:create, :update, :show, :destroy] do
      resources :comments, only: [:index, :create, :update, :show, :destroy]
    end
  end
  resources :comments, only: [:show,:create,:edit, :update, :destroy] 
  
  resources :posts do
    resources :likes, only: [:index, :create, :destroy]
  end
end
