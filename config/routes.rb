Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users

  resources :stations

  resources :conditions, only: [:index, :show]

  resources :trips, only: [:index, :show]

  get '/:station_name', to: 'stations#show'

end
