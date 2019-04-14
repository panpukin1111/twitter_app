Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'      # rails g のときにデフォルトで作成された この２つはいらない？
  get 'users/new'
  root 'static_pages#home'
  get '/home', to:'static_pages#home'
  get '/help', to:'static_pages#help'     # get 'static_pages/help'　でも可
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get '/signup', to:'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  # authenticate :user do
  namespace :admin do
    resources :groups do
      resources :users, controller: :group_users
    end
    resources :users do
      resources :microposts, controller: :user_microposts, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :groups, controller: :user_groups
    end
    root 'pages#index'
  end
  # end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :groups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
