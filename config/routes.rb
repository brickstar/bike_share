Rails.application.routes.draw do

  root 'welcome#index'

  resources :stations

  resources :conditions, only: [:index]

  resources :trips, only: [:index, :show]

  get '/:station_name', to: 'stations#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


end
