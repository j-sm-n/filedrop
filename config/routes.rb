Rails.application.routes.draw do

  root "home#index"

  resources :documents, only:[:index]
  resources :users, only:[:new, :create, :edit, :update]

  get '/users/verify', to: 'users#show_verify', as: 'verify'
  post 'users/verify'
  post 'users/resent'

  get '/dashboard', to: 'users#show'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'


end
