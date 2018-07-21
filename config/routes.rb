Rails.application.routes.draw do

  resources :stations
  resources :conditions, only: [:index]
end
