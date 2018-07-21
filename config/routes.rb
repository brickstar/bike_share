Rails.application.routes.draw do
  get "/:station_name", to: 'stations#show'
end
