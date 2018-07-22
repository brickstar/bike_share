Rails.application.routes.draw do

  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#show'
  get '/trips-dashboard', to: 'trips_dashboard#index'
  get '/bike-shop', to: 'accessories#index'
  get '/bike-shop/:id', to: 'accessories#show'
  resources :accessories, only: [:index, :show], path: 'bikeshop'

  resources :users, only: [:new, :create]

  resources :stations

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  

  get '/:station_name', to: 'stations#show'

end
