Rails.application.routes.draw do
  resources :static, only: [:index, :show]
  root to: 'static#index'
end
