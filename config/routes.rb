Rails.application.routes.draw do
  get '/auth/begin', to: 'auth#begin'
  get '/auth/finish', to: 'auth#finish'
  post '/events', to: 'events#new'
end
