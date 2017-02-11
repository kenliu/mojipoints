Rails.application.routes.draw do
  get 'events/new'

  get '/begin_auth', to: 'auth#begin_auth'
  get '/finish_auth', to: 'auth#finish_auth'
  post '/events', to: 'events#new'
end
