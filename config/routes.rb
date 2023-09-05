Rails.application.routes.draw do
  post 'login', to: 'users#login'
  
  resources :users, only: [:show,:create,:index], shallow: true do
    post 'follow', on: :member
    post 'unfollow', on: :member
  end

  resources :posts, only: [:index, :create, :show, :update , :destroy] do
    resources :comments, only: [:create, :index, :update, :destroy] do
      get 'edit', on: :member
    end

    resources :likes, only: [:index, :create, :destroy]
  end

  post 'blocks/:id', to: 'blocks#create', as: 'block_user'
  delete 'blocks/:id', to: 'blocks#destroy', as: 'unblock_user'
  

  post 'follows/:id', to: 'users#follow', as: 'user_follows'
  delete 'follows/:id', to: 'users#unfollow', as: 'user_unfollows'

  patch 'users/:id', to: 'users#update', as: 'update_user'
  delete 'users/:id', to: 'users#destroy', as: 'delete_user'
end
