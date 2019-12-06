Rails.application.routes.draw do
  resources :static, only: [:index]
  get '/show', to: 'static#show'
  root to: 'static#index'
end
