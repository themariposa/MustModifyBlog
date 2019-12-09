Rails.application.routes.draw do

  root "posts#index"

  get 'home', to: 'posts#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'blog', to: 'blog#index', as: 'blog'
  get 'lab_notes', to: 'lab_notes#index', as: 'lab_notes'
  get 'pages/:action', controller: 'pages'
  #get '/:name' => 'posts#user_posts', as: :user_posts

  resources :comments
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
