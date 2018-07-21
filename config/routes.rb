Rails.application.routes.draw do

  resources :stations

  resources :conditions, only: [:index]

  resources :trips, only: [:index, :show]

  get '/:station_name', to: 'stations#show'
  
end
