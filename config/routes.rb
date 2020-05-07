Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
    collection do
      get :search
    end
  end
  
  resources :articles do
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
  get '/articles/hashtag/:hashtag_id', to: "articles#hashtag"
  get "/articles/category/:category_id", to: "articles#category"
  
  resources :hashtags, only: [:index]
end
