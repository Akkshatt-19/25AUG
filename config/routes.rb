Rails.application.routes.draw do
  
  resources :users
  post 'user/login', to: 'users#login'
  post 'user/signup', to: 'users#signup'
  
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  
  resources :blocks
  resources :follows
  resources :posts
  
  post 'users/:user_id/follows/:id', to: 'follows#post'
  
  resources :users do
    resources :posts
  end
  
  resources :users do
    resources :posts, only: [:create, :update, :show, :destroy]
    resources :follows
  end
  
  resources :users do
    resources :posts do
      resources :comments
    end
  end
  
  resources :comments, only: [:show,:create,:edit, :update, :destroy] 
  
  resources :posts do
    resources :likes, only: [:index, :create, :destroy]
  end
end
