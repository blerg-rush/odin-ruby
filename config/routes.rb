Rails.application.routes.draw do
  get 'invitations/new'
  get 'invitations/create'
  get 'events/new'
  get 'events/create'
  get 'events/show'
  root 'static#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#show'
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :events
  resources :invitations
end
