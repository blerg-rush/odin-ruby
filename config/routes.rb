Rails.application.routes.draw do
  get 'flights/index'
  get 'flights/show'
  get 'flights/new'
  get 'flights/create'
  get 'flights/edit'
  get 'flights/update'
  get 'flights/destroy'
  devise_for :users

  root to: 'flights#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
