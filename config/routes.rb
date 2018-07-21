Rails.application.routes.draw do
  resources :trips, only: [:index]
  get '/:station_name', to: 'stations#show'
end
