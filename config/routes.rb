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

  resources :stations

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  resources :orders, only: [:show]

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'

    resources :trips, except: [:index, :show]

    resources :stations

    resources :conditions, except: [:index, :show]
  end

  get '/:station_name', to: 'stations#show'

end
