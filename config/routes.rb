Rails.application.routes.draw do
  get 'posts/new'
  post 'posts/create'
  get 'posts/index'
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "static_pages#lol"
end
