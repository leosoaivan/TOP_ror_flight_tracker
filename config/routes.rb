Rails.application.routes.draw do
  root 'flights#index'

  get 'flights', to: 'flights#index'
  
  get 'bookings/new', to: 'bookings#new'
  post 'bookings', to: 'bookings#create'
  get 'bookings/:id', to: 'bookings#show', as: 'booking'
end
