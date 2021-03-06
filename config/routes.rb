Rails.application.routes.draw do

  root "pages#welcome"

  constraints :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ do
    get ':year/:month/:day/:slug' => 'posts#show'
  end

  get 'home', to: 'posts#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'pages/:action', controller: 'pages'
  get 'category_posts' => 'posts#category_posts'
  #get '/:name' => 'posts#user_posts', as: :user_posts

  resources 'birdsongs'

  resources :comments
  resources :posts
  resources :projects
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get '/portfolio' => redirect('/projects')
end
