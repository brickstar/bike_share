Rails.application.routes.draw do

  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#show'
  get '/trips-dashboard', to: 'trips_dashboard#index'
  get '/stations-dashboard', to: 'stations_dashboard#index'

  resources :accessories, only: [:index, :show], path: 'bikeshop'

  resources :carts, only: [:create]

  resources :users, only: [:new, :create]

  resources :stations

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  namespace :admin do
    resources :dashboard, only: [:show]
  end

  get '/:station_name', to: 'stations#show'

end
