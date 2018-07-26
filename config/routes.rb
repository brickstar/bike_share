Rails.application.routes.draw do

  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#show'
  get '/trips-dashboard', to: 'trips_dashboard#index'
  get '/stations-dashboard', to: 'stations_dashboard#index'
  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create'
  delete '/cart', to: 'cart#destroy'

  resources :accessories, only: [:index, :show], path: 'bike-shop'
  resources :users, only: [:new, :create, :edit, :update]
  resources :stations, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :trips, only: [:index, :show]

  namespace :admin do
    resources :trips, except: [:index, :show]
    resources :stations, only: [:new, :create, :edit, :update, :destroy]
    resources :dashboard, only: [:show]
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
  end

  get '/:id', to: 'stations#show'

end

