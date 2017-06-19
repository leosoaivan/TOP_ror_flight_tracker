Rails.application.routes.draw do
  root 'flights#index'

  get 'flights', to: 'flights#index'
  get 'bookings/new', to: 'bookings#new'
end
