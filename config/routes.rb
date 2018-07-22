Rails.application.routes.draw do

  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#show'


  resources :users, only: [:new, :create, :show]

  resources :stations

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  get '/:station_name', to: 'stations#show'

end
