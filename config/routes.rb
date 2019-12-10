Rails.application.routes.draw do

  root "posts#index"

  get 'home', to: 'posts#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'pages/:action', controller: 'pages'
  get 'category_posts' => 'posts#category_posts'
  #get '/:name' => 'posts#user_posts', as: :user_posts

  resources :comments
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
